RSpec.describe Shipping, type: :model do
  subject(:shipping) { Shipping.new(:company => 'Nova poshta', :costs => 42) }
  it 'should be a Shipping class' do
    expect(Shipping.is_a?(Class)).to be_truthy
    expect(Shipping < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:company).of_type(:string) }
  it { should have_db_column(:costs).of_type(:decimal) }

  it { should validate_presence_of(:company) }

  it { is_expected.to respond_to(:name) }

  it '#name' do
    expect(shipping.name).to eq(shipping.company)
  end
end