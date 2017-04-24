class CreateDouBanMovieRatings < ActiveRecord::Migration
  def change
    create_table :dou_ban_movie_ratings do |t|
      t.integer :movie_store_id
      t.string :avg_rating
      t.string :stars
      t.integer :collect_count
      t.integer :douban_id
      t.text :douban_url
      t.text :douban_l_img
      t.text :douban_m_img
      t.text :douban_s_img
      t.timestamps null: false
    end
    add_index :dou_ban_movie_ratings, :movie_store_id, name: 'movie_store_id'
  end
end
