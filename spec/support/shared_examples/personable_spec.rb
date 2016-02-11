require 'rails_helper'

shared_examples 'a personable' do
  describe '#display_name' do
    let(:person) do
      described_class.new(
        first_name: 'Catherine',
        last_name: 'Jones'
      )
    end
    let(:result) { person.display_name }

    it 'concatenates the first and last name' do
      expect(result).to eq('Catherine Jones')
    end
  end
end
