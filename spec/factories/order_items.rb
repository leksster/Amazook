FactoryGirl.define do 
  factory :order_item do |n|
    n.sequence(:price) { |n| n }
    n.sequence(:qty) { |n| n }
    book
  end
end