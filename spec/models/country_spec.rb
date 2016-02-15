RSpec.describe Country, type: :model do
  subject(:country) { Country.new(:name => "Ukraine") }

  it { should have_db_column(:name).of_type(:string) }
  it { should validate_presence_of(:name) }

  
  it { should validate_uniqueness_of(:name) }
end