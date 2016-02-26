class User < ActiveRecord::Base

  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :credit_card

  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy

  accepts_nested_attributes_for :credit_card
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :firstname, :lastname, presence: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable,
         :omniauth_providers => [:facebook]

  rails_admin do
    configure :new_password

    edit do
      exclude_fields :password, :password_confirmation, :confirmation_token
      include_fields :new_password
    end
  end

  def billing
    self.billing_address || self.build_billing_address
  end

  def shipping
    self.shipping_address || self.build_shipping_address
  end

  def card
    self.credit_card || self.build_credit_card
  end
  # Provided for Rails Admin to allow the password to be reset
  def new_password; nil; end

  def new_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end

  def name
    email
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.firstname = auth.info.name.split[0]   # assuming the user model has a name
      user.lastname = auth.info.name.split[1]
      # user.image = auth.info.image # assuming the user model has an image
    end
  end
end
