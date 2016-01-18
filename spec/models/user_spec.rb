describe User do
  subject(:user) { User.new(firstname: 'Alex', lastname: 'Test', email: 'alex@test.com', password: 'secret') }
  it 'should be a User class' do
    expect(User.is_a?(Class)).to be_truthy
    expect(User < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:password).of_type(:string) }
  it { should have_db_column(:firstname).of_type(:string) }
  it { should have_db_column(:lastname).of_type(:string) }

  context 'Validators:' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_uniqueness_of(:email) }
    it 'should validate email address' do
      user1 = User.new(firstname: 'Alex', lastname: 'Test', email: 'alextest.com', password: 'secret')
      expect(user1.valid?).to be_falsey
    end
    it { should have_many(:orders) }
    it { should have_many(:ratings) }
  end 
end