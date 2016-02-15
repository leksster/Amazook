RSpec.describe CreditCard, type: :model do
  describe 'class methods' do
    it { expect(subject.class).to respond_to(:months) }
    it { expect(subject.class).to respond_to(:years) }
  end
  describe 'instance methods' do
    it { should respond_to(:name) }
  end
  
  subject(:card) { CreditCard.new(:number => '11112222444455556666', :cvv => '123', :expiration_month => '02',
                                  :expiration_year => '2015', :firstname => 'Alex', :lastname => 'Smith') }
  it 'should be a CreditCard class' do
    expect(CreditCard.is_a?(Class)).to be_truthy
    expect(CreditCard < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:number).of_type(:string) }
  it { should have_db_column(:cvv).of_type(:string) }
  it { should have_db_column(:expiration_month).of_type(:string) }
  it { should have_db_column(:expiration_year).of_type(:string) }
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