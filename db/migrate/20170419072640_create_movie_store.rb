class CreateMovieStore < ActiveRecord::Migration
  def change
    create_table :movie_stores do |t|
      t.integer :year
      t.string :title
      t.string :des
      t.string :resolution
      t.text :img_cover
      t.text :pre_img
      t.string :language
      t.text :resource_addr
      t.integer :order_level
      t.string :movie_type
      t.timestamps null: false
    end
    add_index :movie_stores, :order_level, name: :order_level, unique: true
  end
end
