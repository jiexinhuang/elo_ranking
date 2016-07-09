require 'rails_helper'

RSpec.describe Elo::Configuration do
  subject(:configuration) { described_class.new }
  describe 'default configuration values' do
    its(:default_rating) { is_expected.to eq 1500 }
    its(:pro_rating_boundary) { is_expected.to eq 2500 }
    its(:starter_games_boundary) { is_expected.to eq 20 }
    its(:starter_k_factor) { is_expected.to eq 25 }
    its(:default_k_factor) { is_expected.to eq 15 }
    its(:pro_k_factor) { is_expected.to eq 10 }
  end

  describe 'use custom config' do
    before do
      configuration.config.default_rating = 2000
      configuration.config.pro_rating_boundary = 3000
      configuration.config.starter_games_boundary = 40
      configuration.config.starter_k_factor= 50
      configuration.config.default_k_factor = 30
      configuration.config.pro_k_factor = 20
    end

    its(:default_rating) { is_expected.to eq 2000 }
    its(:pro_rating_boundary) { is_expected.to eq 3000 }
    its(:starter_games_boundary) { is_expected.to eq 40 }
    its(:starter_k_factor) { is_expected.to eq 50 }
    its(:default_k_factor) { is_expected.to eq 30 }
    its(:pro_k_factor) { is_expected.to eq 20 }
  end
end
