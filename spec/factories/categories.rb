FactoryGirl.define do 
  factory :category do
    sequence(:title) { |n| "#{Faker::Hacker.noun}_#{n}" }
  end
end