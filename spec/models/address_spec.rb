describe Address do
  it 'should be a Address class' do
    expect(Address.is_a?(Class)).to be_truthy
    expect(Address < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:address).of_type(:string) }
  it { should have_db_column(:zipcode).of_type(:string) }
  it { should have_db_column(:city).of_type(:string) }
  it { should have_db_column(:phone).of_type(:string) }
  it { should have_db_column(:country).of_type(:string) }

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:country) }

end