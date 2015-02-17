class CreateMovieRatings < ActiveRecord::Migration
  def change
    create_table :movie_ratings do |t|
      t.references :user, index: true
      t.references :movie, index: true
      t.integer :value

      t.timestamps null: false
    end
    add_foreign_key :movie_ratings, :users
    add_foreign_key :movie_ratings, :movies
  end
end
