class ApiController < ApiApplicationController

  api_get :movie do
    page = params[:page]
    MovieStore.includes(:dou_ban_movie_rating).order(order_level: :desc).page(page).map do |item|
      rating = {}
      if item.dou_ban_movie_rating && item.dou_ban_movie_rating.stars.present?
        rating = {
            rating: {
                stars: item.dou_ban_movie_rating.stars,
                avg_rating: item.dou_ban_movie_rating.avg_rating,
                collect_count: item.dou_ban_movie_rating.collect_count,
                from: '豆瓣'
            }
        }
      end
      {
          title: item.title,
          img_cover: item.img_cover,
          des: '',
      }.merge rating
    end
  end

  api_get :douban_search do
    res = HTTParty.get('https://api.douban.com/v2/movie/search', query: {q: params[:q]})
    res['subjects'].select { |item| item['title']==params[:q] }
  end

  api_post :movie do
    1234
  end
end
