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

class SubscriptionsController < ApplicationController
  include Constants

  def join
    @user = User.new
    @child = Child.new
    @months = MONTHS
    @states = US_STATES
  end

  def create

  end
end
