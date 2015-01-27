class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :runtime
      t.string :genre
      t.string :director
      t.string :actors
      t.string :country
      t.string :awards
      t.string :poster
      t.string :category
      t.text :plot
      t.string :user_id

      t.timestamps null: false
    end
  end
end
