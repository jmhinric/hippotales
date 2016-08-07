# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  phone           :string
#  address_line1   :string
#  address_line2   :string
#  city            :string
#  state           :string
#  zip             :string
#  password_digest :string
#  is_admin        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  include Personable
  include TextUtils

  has_secure_password
  validates :first_name, :last_name, :email, :address_line1, :city, :state, :zip, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates_with Validators::EmailValidator, attributes: [:email]
  has_many :subscriptions
  has_one :customer

  delegate :payment_methods, to: :customer

  before_save :capitalize_fields

  def children
    subscriptions.map(&:children).flatten
  end

  # Creates a json form of the model with selected fields
  def self.as_new
    new.as_json(except: [
      :id,
      :created_at,
      :updated_at,
      :password_digest,
      :is_admin
    ])
  end

  private

  def capitalize_fields
    capitalize_attrs([:first_name, :last_name, :address_line1, :address_line2, :city])
  end
end
