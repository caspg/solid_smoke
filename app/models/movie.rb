class Movie < ActiveRecord::Base
  validates :title,   presence: true, uniqueness: { scope: :year, case_sensitive: false }
  validates :year,    presence: true
  validates :plot,    presence: true, length: { in: 50..1200 } 
  validates :user_id, presence: true
end
