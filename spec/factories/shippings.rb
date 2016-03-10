FactoryGirl.define do
  factory :shipping do |n|
    n.sequence(:company) { |n| "UPS_#{n}" }
    n.sequence(:costs) { |n| n }
  end
end