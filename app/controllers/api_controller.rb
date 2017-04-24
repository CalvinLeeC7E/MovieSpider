class ApiController < ApiApplicationController

  api_get :movie do
    page = params[:page]
    MovieStore.order(order_level: :desc).page(page)
  end

  api_get :douban_search do
    res = HTTParty.get('https://api.douban.com/v2/movie/search', query: {q: params[:q]})
    res['subjects'].select { |item| item['title']==params[:q] }
  end

  api_post :movie do
    1234
  end
end
