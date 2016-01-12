# == Schema Information
#
# Table name: publishers
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Publisher < ActiveRecord::Base
  has_many :books
  validates :name, presence: true, uniqueness: true
end
