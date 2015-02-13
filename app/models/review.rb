class Review < ActiveRecord::Base
  validates :title,    presence: true
  validates :content,  presence: true, length: { in: 10..240 }
  validates :user_id,  presence: true, uniqueness: { scope: :movie_id }
  validates :movie_id, presence: true

  belongs_to :user
  belongs_to :movie
  has_many :review_votes, dependent: :destroy

  def self.by_votes
    select('reviews.*, COALESCE(  SUM(value), 0) AS votes').
    joins('LEFT JOIN review_votes ON review_id=reviews.id').
    group('reviews.id').
    order('votes DESC')
  end

  def votes
    review_votes.sum(:value)
  end
end
