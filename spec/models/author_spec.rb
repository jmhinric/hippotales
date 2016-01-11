require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should have_one :creator }
  it { should have_and_belong_to_many :books }
  it { should delegate_method(:first_name).to(:creator) }
  it { should delegate_method(:middle_name).to(:creator) }
  it { should delegate_method(:last_name).to(:creator) }
  it { should delegate_method(:display_name).to(:creator) }
end
