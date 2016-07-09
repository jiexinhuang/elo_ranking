require 'rails_helper'

RSpec.describe Player, :type => :model do
  it { is_expected.to validate_presence_of :game_type }
  it { is_expected.to validate_presence_of :rating }
  it { is_expected.to belong_to :user }

  let(:user) { User.create(username: 'ronaldo') }
  describe '#games' do
    let(:player1) { Player.create(game_type: 'fifa', user: user, rating: 1000) }
    let(:player2) { Player.create(game_type: 'fifa', user: user, rating: 1000) }
    let(:player3) { Player.create(game_type: 'fifa', user: user, rating: 1000) }
    let!(:game1) { Game.create(game_type: 'fifa', home_player: player1, away_player: player2, result: 1) }
    let!(:game2) { Game.create(game_type: 'fifa', home_player: player2, away_player: player1, result: 1) }
    let!(:game3) { Game.create(game_type: 'fifa', home_player: player1, away_player: player3, result: 1) }
    let!(:game4) { Game.create(game_type: 'fifa', home_player: player3, away_player: player2, result: 1) }

    it 'returns all games played as either home player or away player' do
      expect(player1.games).to eq [game1, game2, game3]
      expect(player2.games).to eq [game1, game2, game4]
      expect(player3.games).to eq [game3, game4]
    end
  end

  describe '#starter?' do
    subject(:player) { Player.create(game_type: 'fifa', user_id: 1, rating: 1000) }
    let(:starter_games_boundary) { 10 }

    before do
      allow(Game).to receive(:where).and_return(double(count: games_count))
      allow(Elo).to receive(:config).and_return(double(starter_games_boundary: starter_games_boundary))
    end

    context 'when player played games less than starter boundary' do
      let(:games_count) { 9 }
      it { is_expected.to be_starter }
    end

    context 'when player played games equal to starter boundary' do
      let(:games_count) { 10 }
      it { is_expected.not_to be_starter }
    end

    context 'when player played games more than starter boundary' do
      let(:games_count) { 11 }
      it { is_expected.not_to be_starter }
    end
  end

  describe '#k_factor' do
    let(:player) { Player.create(game_type: 'fifa', user_id: 1, rating: 1000, pro: pro) }
    let(:pro) { false }
    let(:pro_k_factor) { 10 }
    let(:default_k_factor) { 15 }
    let(:starter_k_factor) { 20 }
    let(:starter_games_boundary) { 50 }
    let(:games_count) { 51 }
    subject(:k_factor) { player.k_factor }

    before do
      allow(Game).to receive(:where).and_return(double(count: games_count))
      allow(Elo).to receive(:config).and_return(
        double(
          starter_games_boundary: starter_games_boundary,
          pro_k_factor: pro_k_factor,
          default_k_factor: default_k_factor,
          starter_k_factor: starter_k_factor,
        )
      )
    end

    context 'when the player is a pro' do
      let(:pro) { true }
      it { is_expected.to eq pro_k_factor }
    end

    context 'when the player is a new starter' do
      let(:games_count) { 1 }
      it { is_expected.to eq starter_k_factor }
    end

    context 'when the player is neither a new starter nor a pro' do
      it { is_expected.to eq default_k_factor }
    end
  end

  describe '#update_rating' do
    let(:player) { Player.create(game_type: 'fifa', user: user, rating: 1000) }
    let(:pro_rating_boundary) { 1500 }
    let(:diff) { 100 }
    subject(:update_rating) { player.update_rating(diff) }
    before do
      allow(Elo).to receive(:config).and_return(double(pro_rating_boundary: pro_rating_boundary))
    end

    it 'updates player rating with diff' do
      expect { update_rating }.to change(player, :rating).by(100)
    end

    context 'when udpated rating is higher or equal to pro_rating_boundary' do
      let(:diff) { 500 }
      it 'updates player rating with diff' do
        expect { update_rating }.to change(player, :pro?).from(false).to(true)
      end
    end
  end
end
