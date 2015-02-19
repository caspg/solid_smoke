class Movie < ActiveRecord::Base
  validates :title,   presence: true, uniqueness: { scope: :year, case_sensitive: false }
  validates :year,    presence: true
  validates :plot,    presence: true, length: { in: 50..1200 } 
  validates :user_id, presence: true
  
  has_many :reviews, dependent: :destroy
  has_many :movie_ratings, dependent: :destroy

  # Paperclip
  has_attached_file :poster
  validates_attachment_content_type :poster, content_type: /\Aimage/
  validates_attachment_file_name :poster, matches: [/png\Z/, /jpe?g\Z/]
  validates_attachment_size :poster, less_than: 1.megabytes

  # Return average rating or 0.0 if no ratings.
  def rating_average
    movie_ratings.average('score').to_f.round(1)
  end

  def rating_count
    movie_ratings.count
  end

  # Paperclip attachment
  def poster_from_url(url_value)
    self.poster = URI.parse(url_value)
  end

end
