class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :review_id, presence: true
end

