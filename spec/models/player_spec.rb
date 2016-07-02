require 'rails_helper'

RSpec.describe Player, :type => :model do
  it { is_expected.to have_many :home_games }
  it { is_expected.to have_many :away_games }
  it { is_expected.to validate_presence_of :game_type }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :rating }
end
