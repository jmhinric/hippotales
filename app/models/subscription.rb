# == Schema Information
#
# Table name: subscriptions
#
#  id             :uuid             not null, primary key
#  duration       :integer
#  cost_per_month :decimal(, )
#  is_gift        :boolean          default(FALSE)
#  gift_message   :text
#  address_line1  :string
#  address_line2  :string
#  city           :string
#  state          :string
#  zip            :string
#  user_id        :uuid
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Subscription < ActiveRecord::Base
  include TextUtils

  validates :duration, :cost_per_month, :address_line1, :city, :state, :zip, presence: true
  belongs_to :user
  has_and_belongs_to_many :children

  def child_names
    and_join(children.map(&:full_name))
  end
end