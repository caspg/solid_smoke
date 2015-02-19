class RemovePosterFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :poster, :string
  end
end
