# == Schema Information
#
# Table name: authors
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Author < ActiveRecord::Base
  has_one :creator
  has_and_belongs_to_many :books

  delegate :first_name, :middle_name, :last_name, :display_name, to: :creator
end
