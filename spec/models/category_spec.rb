RSpec.describe Category, type: :model do
  subject(:category) { Category.new(title: 'yo') }
  
  it 'should be a Category class' do
    expect(Category.is_a?(Class)).to be_truthy
    expect(Category < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:title).of_type(:string) }
  it { should validate_presence_of(:title) }

  
  it { should validate_uniqueness_of(:title) }

  it { should have_many(:books) }
end