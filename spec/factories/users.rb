FactoryGirl.define do 
  factory :user do
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    password "12345"
    sequence(:email) { |n| "#{firstname}_#{n}@example.com" }

    trait :admin do
      admin true
    end

    factory :admin, traits: [:admin]
  end  
end