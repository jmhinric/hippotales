require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :age }
  it { should validate_presence_of :gender }
end
