class Movie < ActiveRecord::Base
  validates :title,   presence: true, uniqueness: { scope: :year, case_sensitive: false }
  validates :year,    presence: true
  validates :plot,    presence: true, length: { in: 50..1200 } 
  validates :user_id, presence: true
  
  has_many :reviews, dependent: :destroy
  has_many :movie_ratings, dependent: :destroy

  # Return average rating or 0.0 if no ratings.
  def rating_average
    movie_ratings.average('score').to_f.round(1)
  end

  def rating_count
    movie_ratings.count
  end
end
