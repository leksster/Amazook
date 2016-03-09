require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { should have_db_column(:code).of_type(:string) }
  it { should have_db_column(:discount).of_type(:integer) }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:discount) }
  it { should validate_inclusion_of(:discount).in_range(1..100) }
end
