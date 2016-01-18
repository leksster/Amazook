describe Order do
  it 'should be a Order class' do
    expect(Order.is_a?(Class)).to be_truthy
    expect(Order < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:total_price).of_type(:decimal) }
  it { should have_db_column(:completed_date).of_type(:date) }
  it { should have_db_column(:state).of_type(:string) }

  it { should belong_to(:user) }
  it { should belong_to(:credit_card) }
  it { should have_one(:address) }
  it { should have_many(:order_items) }

  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:completed_date) }
  it { should validate_presence_of(:state) }
  it { should validate_inclusion_of(:state).in_array(['In progress', 'Shipped', 'Completed']) }

end