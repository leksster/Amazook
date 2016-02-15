RSpec.describe OrderItem, type: :model do
  it 'should be a OrderItem class' do
    expect(OrderItem.is_a?(Class)).to be_truthy
    expect(OrderItem < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:price).of_type(:decimal) }
  it { should have_db_column(:qty).of_type(:integer) }

  it { should belong_to(:order) }
  it { should belong_to(:book) }

  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:qty) }
end