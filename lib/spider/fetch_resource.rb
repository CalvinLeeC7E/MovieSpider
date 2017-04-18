require 'open-uri'
require 'spider/dom_parser'
require 'spider/movie'
module Spider
  class FetchResource
    attr_accessor :host

    def initialize
      self.host = 'http://www.ygdy8.net'
    end

    def get_html(url)
      response = HTTParty.get(url, {timeout: 5000})
      return '' unless response.code == 200
      html = response.body
      html.encode 'utf-8', 'GB18030', {:invalid => :replace}
    end

    def get_doms(html)
      Nokogiri::HTML::Document.parse html
    end

    def fetch(url)
      get_doms(get_html(self.host + url))
    end

    def fetch_pages(size)
      url_addr = '/html/gndy/dyzz/index.html'
      Spider::DOMParser.pages_parser(fetch(url_addr))
          .map(&lambda { |item| item['value'] }).slice(0, size)
    end

    def fetch_movies(page)
      url_addr = '/html/gndy/dyzz/'
      movies = fetch_pages(page).inject([]) do |result, url|
        result.concat Spider::DOMParser.movie_parser(fetch(url_addr+url))
                          .map(&lambda { |item| Spider::Movie.new(item.content, item[:href]) })
      end
      fetch_movies_detail movies
    end

    def fetch_movies_detail(movies)
      movies.each do |item|
        imgs = Spider::DOMParser.movie_detail_parser(fetch(item.resource_addr)).map { |item| item[:src] }
        item.img_cover = imgs[0]
        item.pre_img = imgs[1]
        item.to_store
      end
    end
  end
end