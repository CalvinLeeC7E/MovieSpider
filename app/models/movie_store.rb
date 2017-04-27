class MovieStore < ActiveRecord::Base

  has_one :dou_ban_movie_rating, class_name: 'DouBanMovieRating', foreign_key: 'movie_store_id'

  def have_update_douban
    self.update_attribute :dou_ban_update_time, Time.now
  end
end