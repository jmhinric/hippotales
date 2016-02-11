# == Schema Information
#
# Table name: subscriptions
#
#  id                   :uuid             not null, primary key
#  duration             :integer
#  cost_per_month       :decimal(, )
#  is_gift              :boolean          default(FALSE)
#  gift_message         :text
#  address_line1        :string
#  address_line2        :string
#  city                 :string
#  state                :string
#  zip                  :string
#  user_id              :uuid
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subscription_cost_id :uuid
#

class Subscription < ActiveRecord::Base
  include TextUtils

  validates :duration, :cost_per_month, :address_line1, :city, :state, :zip, presence: true
  belongs_to :user
  belongs_to :subscription_cost
  has_and_belongs_to_many :children

  def child_names
    and_join(children.map(&:display_name))
  end
end
