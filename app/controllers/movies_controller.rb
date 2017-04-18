class MoviesController < ApplicationController
  def index
    page = params[:page]
    @movies = MovieStore.order(id: :asc).page(page)
  end
end
