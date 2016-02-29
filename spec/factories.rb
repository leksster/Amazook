FactoryGirl.define do 
  factory :user do |n|
    n.sequence(:firstname) { |n| "#{Faker::Name.first_name}_#{n}" }
    lastname Faker::Name.last_name
    password "12345"
    email { "#{firstname}@example.com" }
  end  

  factory :country do
    name Faker::Address.country
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

  factory :rating do |n|
    rating 5
    review_text "Lorem ipsum"
  end

  factory :category do |n|
    n.sequence (:title) { |n| "Lorem_#{n}" }
  end

  factory :author do |n|
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
  end

  factory :order do |n|
    total_price Faker::Number.decimal(2)
    completed_date Faker::Time.between(DateTime.now - 2, DateTime.now - 1)
    aasm_state 'in_progress'
  end

  factory :order_item do |n|
    n.sequence(:price) { |n| n }
    n.sequence(:qty) { |n| n }
  end

  factory :shipping do |n|
    n.sequence(:company) { |n| "UPS_#{n}" }
    n.sequence(:costs) { |n| n }
  end

  factory :billing_address do |n|
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    address Faker::Address.street_address
    zipcode Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
    country Faker::Number.between(1, 50)
  end

  factory :shipping_address do |n|
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    address Faker::Address.street_address
    zipcode Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
    country Faker::Number.between(1, 50)
  end

  factory :credit_card do |n|
    number '1111111111111111'
    cvv '123'
    expiration_year '2020'
    expiration_month '02'
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
  end
end