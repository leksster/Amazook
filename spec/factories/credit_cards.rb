FactoryGirl.define do 
  factory :credit_card do
    number '1111111111111111'
    cvv '123'
    expiration_year '2020'
    expiration_month '02'
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
  end
end