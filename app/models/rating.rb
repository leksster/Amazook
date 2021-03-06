class Rating < ActiveRecord::Base
  include AASM
  belongs_to :book
  belongs_to :user
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :review_text, presence: true
  validates :aasm_state, presence: true

  aasm do
    state :pending, :initial => true
    state :approved
    state :declined
  end

  rails_admin do
    edit do
      include_all_fields
    end
    list do
      field :id
      field :aasm_state
      field :rating
      include_all_fields
    end
  end

  def aasm_state_enum
    self.class.aasm.states_for_select
  end
end
