require 'rails_helper'
require_relative '../support/shared_examples/personable_spec'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  [:first_name, :last_name, :email, :address_line1, :city, :state, :zip].each do |attr|
    it { should validate_presence_of(attr) }
  end

  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should_not allow_value('test').for(:email) }
  it { should allow_value('test@test.com').for(:email) }
  it { should have_many :subscriptions }

  it_behaves_like 'a personable'
end
