FactoryGirl.define do 
  factory :category do |n|
    n.sequence(:title) { "#{Faker::Hacker.noun}_#{n}" }
  end
end