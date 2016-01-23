require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should validate_presence_of :duration }
  it { should validate_presence_of :cost_per_month }
  it { should validate_presence_of :address_line1 }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :zip }
  it { should belong_to :user }
end
