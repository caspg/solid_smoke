class Review < ActiveRecord::Base
  validates :title,    presence: true
  validates :content,  presence: true, length: { in: 10..240 }
  validates :user_id,  presence: true, uniqueness: { scope: :movie_id }
  validates :movie_id, presence: true
  belongs_to :user
  belongs_to :movie
end