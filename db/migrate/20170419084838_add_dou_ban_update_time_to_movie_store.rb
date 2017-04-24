class AddDouBanUpdateTimeToMovieStore < ActiveRecord::Migration
  def change
    add_column :movie_stores, :dou_ban_update_time, :datetime
    add_index :movie_stores, :dou_ban_update_time, name: 'dou_b_update_time'
  end
end
