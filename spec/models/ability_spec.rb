require "cancan/matchers"

RSpec.describe Ability do
  describe 'admin\'s abilities' do
    let(:admin) { create(:admin) }
    let(:ability) { Ability.new(admin) }
  
    context 'can' do
      it { expect(ability).to be_able_to(:manage, :all) }
    end
  end

  describe 'user\'s abilities' do
    let(:user) { create(:user) }
    let(:ability) { Ability.new(user) }
    let(:order) { create(:order, user: user) }

    context 'can' do
      it 'edit own orders with .in_progress state' do
        expect(ability).to be_able_to(:edit, order)
      end
      it 'update own orders with .in_progress state' do
        expect(ability).to be_able_to(:update, order)
      end
      it 'show own orders' do
        expect(ability).to be_able_to(:show, order)
      end
      it 'read book with qty > 0' do
        expect(ability).to be_able_to(:read, create(:book))
      end
    end

    context 'cannot' do
      it { expect(ability).not_to be_able_to(:manage, :all) }
      it { expect(ability).not_to be_able_to(:access, :rails_admin) }

      it 'edit someone else\'s orders with .in_progress state' do
        expect(ability).not_to be_able_to(:edit, create(:order, :user=>create(:user)))
      end
      it 'update someone else\'s orders with .in_progress state' do
        expect(ability).not_to be_able_to(:update, create(:order, :user=>create(:user)))
      end
      it 'edit own orders with not .in_progress state' do
        expect(ability).not_to be_able_to(:edit, create(:order, :user => user, :aasm_state => 'in_queue'))
      end
      it 'update own orders with not .in_progress state' do
        expect(ability).not_to be_able_to(:update, create(:order, :user => user, :aasm_state => 'in_delivery'))
      end
      it 'read book with qty == 0' do
        expect(ability).not_to be_able_to(:read, create(:book, qty: 0))
      end
    end
  end
end