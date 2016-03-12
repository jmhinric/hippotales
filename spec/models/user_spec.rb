require 'rails_helper'
require_relative '../support/shared_examples/personable_spec'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }

  [:first_name, :last_name, :email, :address_line1, :city, :state, :zip].each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to_not allow_value('test').for(:email) }
  it { is_expected.to allow_value('test@test.com').for(:email) }

  it { is_expected.to have_many :subscriptions }
  it { is_expected.to have_one :customer }

  it_behaves_like 'a personable'
end
