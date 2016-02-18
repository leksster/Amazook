RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:encrypted_password).of_type(:string) }
  it { should have_db_column(:firstname).of_type(:string) }
  it { should have_db_column(:lastname).of_type(:string) }
  it { should have_db_column(:admin).of_type(:boolean) }

  it { should have_many(:ratings) }
  it { should have_many(:orders).dependent(:destroy) }
  it { should have_one(:credit_card) }
  it { should have_one(:billing_address).dependent(:destroy) }
  it { should have_one(:shipping_address).dependent(:destroy) }

  it { should accept_nested_attributes_for(:credit_card) }
  it { should accept_nested_attributes_for(:shipping_address) }
  it { should accept_nested_attributes_for(:billing_address) }

  it { is_expected.to respond_to(:billing) }
  it { is_expected.to respond_to(:shipping) }
  it { is_expected.to respond_to(:card) }

  it { should allow_value("email@me.com").for(:email) }
  it { should_not allow_value("WSvd@asfgW").for(:email) }
  

  it { should validate_uniqueness_of(:email).case_insensitive }
end
