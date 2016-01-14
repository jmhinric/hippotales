require 'rails_helper'

RSpec.describe ContactComment, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :message }
end
