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
#  active               :boolean          default(TRUE)
#  status               :integer          default(0)
#  payment_method_id    :uuid
#

require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

end
