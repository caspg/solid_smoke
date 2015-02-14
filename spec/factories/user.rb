FactoryGirl.define do
  sequence :username do |n|
    "rspec#{n}"
  end

  sequence :email do |n|
    "rspec#{n}@spec.com"
  end

  factory :user do
      username 
      email    
      password "password"
  end
end
