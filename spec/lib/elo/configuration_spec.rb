require 'rails_helper'

RSpec.describe Elo::Configuration do
  subject(:configuration) { described_class.new }
  describe 'default configuration values' do
    its(:default_rating) { is_expected.to eq 1000 }
    its(:pro_rating_boundry) { is_expected.to eq 2000 }
    its(:starter_boundry) { is_expected.to eq 20 }
  end

  describe 'use custom config' do
    before do
      configuration.config.default_rating = 2000
      configuration.config.pro_rating_boundry = 3000
      configuration.config.starter_boundry = 40
    end

    its(:default_rating) { is_expected.to eq 2000 }
    its(:pro_rating_boundry) { is_expected.to eq 3000 }
    its(:starter_boundry) { is_expected.to eq 40 }
  end
end
