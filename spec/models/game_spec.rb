require 'rails_helper'

RSpec.describe Game, :type => :model do
  it { is_expected.to belong_to :home_player }
  it { is_expected.to belong_to :away_player }
  it { is_expected.to validate_presence_of :game_type }
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_presence_of :home_player }
  it { is_expected.to validate_presence_of :away_player }

  describe '#expected_result' do
    let(:home_player) { Player.new(rating: home_rating) }
    let(:away_player) { Player.new(rating: away_rating) }
    let(:game) { Game.new }
    subject(:expected_result) { game.expected_result }

    before do
      game.home_player = home_player
      game.away_player = away_player
    end

    context 'when both players have the same rating' do
      let(:home_rating) { 1000 }
      let(:away_rating) { 1000 }

      it { is_expected.to eq 0.5 }
    end

    context 'when the home player rating is 1000 more than away player' do
      let(:home_rating) { 2000 }
      let(:away_rating) { 1000 }

      it 'home player can win more than 99 times out of 100 games' do
        expect(expected_result > 0.99).to eq true
      end
    end

    context 'when the home player rating is 1000 less than away player' do
      let(:home_rating) { 2000 }
      let(:away_rating) { 3000 }

      it 'home player can win less than 1 time out of 100 games' do
        expect(expected_result < 0.01).to eq true
      end
    end
  end
end
