require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it { is_expected.to validate_presence_of :token }
  it { is_expected.to validate_presence_of :payment_method }
  it { is_expected.to delegate_method(:braintree_customer_id).to(:customer) }

  it { is_expected.to belong_to :customer }
  it { is_expected.to have_many :subscriptions }
end
