describe Author do
  subject(:author) { Author.new(firstname: 'Name', lastname: 'Second') }

  it { should have_db_column(:firstname).of_type(:string) }
  it { should have_db_column(:lastname).of_type(:string) }
  it { should have_db_column(:biography).of_type(:text) }

  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }

  it { should have_many(:books) }
end