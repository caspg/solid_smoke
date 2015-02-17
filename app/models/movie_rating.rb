class MovieRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates_presence_of :user
  validates_presence_of :movie
  validates_inclusion_of :value, in: 1..5
  validates_uniqueness_of :movie_id, scope: :user_id
end
