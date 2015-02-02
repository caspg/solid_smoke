FactoryGirl.define do
  factory :review do
    title "Excelent movie"
    content "explanation why this movie was excelent"
    user
    movie
  end
end
