describe CreditCard do
  it 'should be a CreditCard class' do
    expect(CreditCard.is_a?(Class)).to be_truthy
    expect(CreditCard < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:number).of_type(:string) }
  it { should have_db_column(:cvv).of_type(:string) }
  it { should have_db_column(:expiration_month).of_type(:integer) }
  it { should have_db_column(:expiration_year).of_type(:integer) }
  it { should have_db_column(:firstname).of_type(:string) }
  it { should have_db_column(:lastname).of_type(:string) }

  it { should belong_to(:user) }
  it { should have_many(:orders) }

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:cvv) }
  it { should validate_presence_of(:expiration_month) }
  it { should validate_presence_of(:expiration_year) }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }

end