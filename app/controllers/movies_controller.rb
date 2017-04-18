class MoviesController < ApplicationController
  def index
    page = params[:page]
    fetch_res = Spider::FetchResource.new
    fetch_res.fetch_movies(1)
    @movies = MovieStore.page(page)
  end
end
