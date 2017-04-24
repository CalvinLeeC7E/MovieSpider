module Spider
  class DouBanMovie
    def fetch_douban_ratings
      MovieStore.where(dou_ban_update_time: nil).find_each(batch_size: 500) do |record|
        movie_rating = douban_movie_api record.title
        sleep 3
        next unless movie_rating
        douban_movie = DouBanMovieRating.find_or_create_by(movie_store_id: record.id)
        update_data = douban_to_json_data movie_rating
        next unless update_data
        douban_movie.update_attributes update_data
        record.have_update_douban
      end
    end

    # 多线程方案（豆瓣有反爬虫，需要使用ip代理）
    def douban_movie_api_by_queue(queue)
      threads = []
      40.times.each do
        threads << Thread.new do
          while !queue.empty?
            movie_obj = queue.pop
            movie_rating = douban_movie_page movie_obj.title
            if movie_rating
              ActiveRecord::Base.connection_pool.with_connection do
                douban_movie = DouBanMovieRating.find_or_create_by(movie_store_id: movie_obj.id)
                douban_movie.update_attributes douban_page_to_json_data(movie_rating)
                movie_obj.have_update_douban
              end
            end
          end
        end
      end
      threads.each { |item| item.join }
    end

    # 多线程方案的页面解析
    def douban_movie_page(title)
      html = HTTParty.get('https://movie.douban.com/subject_search', timeout: 5000, query: {search_text: title})
      doms = Nokogiri::HTML::Document.parse html
      douban_movie_infos = []
      doms.css('.pl2').map do |item|
        douban_rating = {ratings: []}
        item.css('a').each do |a_item|
          title = a_item.content.gsub(/\r\n|\n| /, '').split('/').select(&lambda { |name| name==title }).fetch(0, nil)
          douban_rating.merge! title: title, url: a_item['href'] if title
        end
        item.css('.star span').each do |span_item|
          douban_rating[:ratings] << [span_item[:class].gsub('allstar', ''), span_item.content.gsub(/\(|\)|人评价/, '')]
        end
        douban_movie_infos << douban_rating if douban_rating.has_key? :title
      end
      douban_movie_infos.fetch(0, nil)
    end

    def douban_movie_api(title)
      res = HTTParty.get('https://api.douban.com/v2/movie/search', query: {q: title})
      return nil if res.code != 200
      res['subjects'].select(&lambda { |item| item['title'] == title }).fetch(0, nil) rescue nil
    end

    def douban_to_json_data(douban)
      begin
        {
            douban_id: douban['id'],
            avg_rating: douban['rating']['average'],
            stars: douban['rating']['stars'],
            collect_count: douban['collect_count'],
            douban_url: douban['alt'],
            douban_l_img: douban['images']['large'],
            douban_m_img: douban['images']['medium'],
            douban_s_img: douban['images']['small']
        }
      rescue
        nil
      end
    end

    # 多线程方案的数据解析
    def douban_page_to_json_data(douban)
      {
          avg_rating: (douban[:ratings][1][1] rescue nil),
          stars: (douban[:ratings][0][0] rescue nil),
          collect_count: (douban[:ratings][2][1] rescue nil),
          douban_url: (douban[:url] rescue nil),
      }
    end
  end
end