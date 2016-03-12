require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { is_expected.to validate_presence_of :braintree_customer_id }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }

  it { is_expected.to have_many :payment_methods }
  it { is_expected.to belong_to :user }
end
