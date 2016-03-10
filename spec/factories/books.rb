FactoryGirl.define do 
  factory :book do |n|
    n.sequence(:title) { |n| "Book_#{n}" }
    description "Lorem Lorem lorem"
    price 52.2
    qty 4
  end
end