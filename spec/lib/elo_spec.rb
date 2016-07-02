require 'rails_helper'

RSpec.describe Elo do
  describe '.config' do
    it 'returns instance of Elo::Configuration' do
      expect(Elo.config).to be_instance_of Elo::Configuration
    end
  end
end
