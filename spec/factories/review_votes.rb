FactoryGirl.define do
  factory :review_vote do
    review
    user
    value 1
  end
end
