RSpec.describe Order, type: :model do
  subject(:order) { Order.new(:total_price => 12, :completed_date => '2016') }

  it 'should be a Order class' do
    expect(Order.is_a?(Class)).to be_truthy
    expect(Order < ActiveRecord::Base).to be_truthy
  end

  it 'should include AASM module' do
    expect(Order.include?(AASM)).to be_truthy
  end

  it { is_expected.to respond_to(:subtotal) }
  it { is_expected.to respond_to(:aasm_state_enum) }

  it { should have_db_column(:total_price).of_type(:decimal) }
  it { should have_db_column(:completed_date).of_type(:date) }
  it { should have_db_column(:aasm_state).of_type(:string) }

  it { should belong_to(:user) }
  it { should have_one(:credit_card) }
  it { should belong_to(:shipping) }
  it { should have_one(:billing_address) }
  it { should have_one(:shipping_address) }
  it { should have_many(:order_items).dependent(:destroy) }

  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:completed_date) }
  it { should validate_presence_of(:aasm_state) }
  it { should validate_numericality_of(:total_price) }
  it { should validate_inclusion_of(:aasm_state).in_array(['in_progress', 'in_queue', 'in_delivery', 'delivered', 'canceled']) }

  it 'should have 5 specified aasm states' do
    expect(Order.aasm.states.map(&:name)).to eq([:in_progress, :in_queue, :in_delivery, :delivered, :canceled])
  end

  it 'should have in_progress state on initialize' do
    expect(order).to have_state(:in_progress)
  end

  it 'should change in_progress state to in_queue on queue event' do
    expect(order).to transition_from(:in_progress).to(:in_queue).on_event(:queued)
  end

end