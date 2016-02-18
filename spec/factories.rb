FactoryGirl.define do 
  factory :user do |n|
    n.sequence(:firstname) { |n| "#{Faker::Name.first_name}_#{n}" }
    lastname Faker::Name.last_name
    password "12345"
    email { "#{firstname}@example.com" }
  end  

  factory :admin, class: User do
    firstname "Admin"
    lastname "Smith"
    password "12345"
    password_confirmation "12345"
    email { "#{firstname}@example.com" }
    admin true
  end

  factory :book do |n|
    n.sequence(:title) { |n| "Book_#{n}" }
    description "Lorem Lorem lorem"
    price 52.2
    qty 4
  end

  factory :category do |n|
    n.sequence (:title) { |n| "Lorem_#{n}" }
  end
end