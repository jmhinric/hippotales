# == Schema Information
#
# Table name: children
#
#  id         :uuid             not null, primary key
#  first_name :string
#  last_name  :string
#  birthday   :date
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Child < ActiveRecord::Base
  include Personable
  include TextUtils

  validates :first_name, :last_name, :birthday, :gender, presence: true
  validates :last_name, :uniqueness => {:scope => [:first_name, :birthday]}
  has_and_belongs_to_many :subscriptions

  enum gender: ['boy', 'girl']

  before_save :capitalize_fields

  # Creates a json form of the model with selected fields
  def self.as_new
    new.as_json(except: [:id, :created_at, :updated_at])
  end

  private

  def capitalize_fields
    capitalize_attrs([:first_name, :last_name])
  end
end
