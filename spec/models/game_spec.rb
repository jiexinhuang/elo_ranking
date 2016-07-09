require 'rails_helper'

RSpec.describe Game, :type => :model do
  it { is_expected.to belong_to :home_player }
  it { is_expected.to belong_to :away_player }
  it { is_expected.to validate_presence_of :game_type }
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_presence_of :home_player }
  it { is_expected.to validate_presence_of :away_player }

  let(:home_player) { Player.new(rating: home_rating) }
  let(:away_player) { Player.new(rating: away_rating) }

  describe '#expected_result' do
    subject(:expected_result) { game.expected_result }
    let(:game) { Game.new(home_player: home_player, away_player: away_player) }

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

  describe '#result_gap' do
    subject(:result_gap) { game.result_gap }
    let(:game) { Game.new(home_player: home_player, away_player: away_player, result: result) }
    let(:home_rating) { 2000 }
    let(:away_rating) { 2000 }

    context 'equally strong players and home player wins' do
      let(:result) { 1.0 }
      it { is_expected.to eq 0.5 }
    end

    context 'equally strong players and away player wins' do
      let(:result) { 0.0 }
      it { is_expected.to eq -0.5 }
    end

    context 'equally strong players and game is a draw' do
      let(:result) { 0.5 }
      it { is_expected.to eq 0.0}
    end
  end
end
