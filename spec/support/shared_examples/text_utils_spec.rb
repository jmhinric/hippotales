require 'rails_helper'

shared_examples 'text utils' do
  let(:model) { described_class.new }

  describe '#and_join' do
    let(:array) { ['first', 'second', 'third', 'fourth'] }

    it 'joins single element arrays' do
      expect(model.and_join(['first'])).to eq('first')
    end

    it 'joins two element arrays' do
      expect(model.and_join(['first', 'second'])).to eq('first and second')
    end

    it 'joins multiple element arrays' do
      expect(model.and_join(array)).to eq('first, second, third, and fourth')
    end
  end

end

describe 'TextUtils' do
  # User model includes TextUtils
  let(:model) { User.new }

  describe '#capitalize_attrs' do
    it 'capitalizes the given attrs' do
      model.first_name = 'john'
      model.last_name = 'hinrichs'
      model.address_line1 = 'sOme addRESS for Somewhere'
      model.capitalize_attrs([:first_name, :address_line1])
      expect(model.first_name).to eq('John')
      expect(model.last_name).to eq('hinrichs')
      expect(model.address_line1).to eq('Some Address For Somewhere')
    end
  end

  describe '#capitalize' do
    it 'returns for a nil argument' do
      expect(model.capitalize(nil)).to be_nil
    end
    it 'capitalizes the first letter of the given string' do
      str = 'iLlinOis'
      expect(model.capitalize(str)).to eq('Illinois')
    end
    it 'capitalizes the first letter of every word of the given string' do
      str = 'chicago iS in iLlinOis'
      expect(model.capitalize(str)).to eq('Chicago Is In Illinois')
    end
  end
end
