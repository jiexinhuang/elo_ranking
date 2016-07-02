require 'rails_helper'

RSpec.describe Game, :type => :model do
  it { is_expected.to belong_to :home_player }
  it { is_expected.to belong_to :away_player }
  it { is_expected.to validate_presence_of :game_type }
  it { is_expected.to validate_presence_of :result }
  it { is_expected.to validate_presence_of :home_player }
  it { is_expected.to validate_presence_of :away_player }
end
