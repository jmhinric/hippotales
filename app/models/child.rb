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

  validates :first_name, :last_name, :birthday, :gender, presence: true
  validates :last_name, :uniqueness => {:scope => [:first_name, :birthday]}
  has_and_belongs_to_many :subscriptions

  enum gender: ['boy', 'girl']
end