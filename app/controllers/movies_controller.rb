class MoviesController < ApplicationController
  def index
    page = params[:page]
    @movies = MovieStore.order(order_level: :desc).page(page)
  end
end
