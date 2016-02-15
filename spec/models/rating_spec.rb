describe Rating do
  it 'should be a Rating class' do
    expect(Rating.is_a?(Class)).to be_truthy
    expect(Rating < ActiveRecord::Base).to be_truthy
  end

  it { should have_db_column(:review_text).of_type(:text) }
  it { should have_db_column(:rating).of_type(:integer) }
  it { should have_db_column(:aasm_state).of_type(:string) }

  it { should belong_to(:user) }
  it { should belong_to(:book) }

  it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1) }
  it { should validate_presence_of(:aasm_state) }

end