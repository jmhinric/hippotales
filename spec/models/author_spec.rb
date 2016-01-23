require 'rails_helper'

RSpec.describe Author, type: :model do
  [:first_name, :middle_name, :last_name, :display_name].each do |attr|
    it { should delegate_method(attr).to(:creator) }
  end

  it { should have_and_belong_to_many :books }
  it { should have_one :creator }
end
