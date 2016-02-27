RSpec.describe Book, type: :model do
  it 'should be a Book class' do
    expect(Book.is_a?(Class)).to be_truthy
    expect(Book < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:title).of_type(:string) }
  it { should have_db_column(:description).of_type(:text) }
  it { should have_db_column(:price).of_type(:decimal) }
  it { should have_db_column(:qty).of_type(:integer) }
  it { should have_db_column(:cover).of_type(:string) }

  context 'Validators:' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:qty) }
    it { should validate_numericality_of(:price) }
    it { should validate_numericality_of(:qty) }
  end 
  context 'ActiveRecord' do
    it { should belong_to(:category) }
    it { should belong_to(:author) }
    it { should have_many(:ratings) }
  end
end