# == Schema Information
#
# Table name: creators
#
#  id               :uuid             not null, primary key
#  first_name       :string
#  middle_name      :string
#  last_name        :string
#  creatorable_id   :integer
#  creatorable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Creator < ActiveRecord::Base
  belongs_to :creatorable, polymorphic: true

  validates :first_name, :last_name, presence: true
  validates :last_name, uniqueness: {
    scope: :first_name,
    message: "Creator already exists with that first and last name",
    case_sensitive: false
  }

  def display_name
    middle = middle_name ? middle_name + " " : ""
    first_name + " " + middle + last_name
  end
end
