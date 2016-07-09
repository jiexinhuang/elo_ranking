class Elo::Configuration
  include ActiveSupport::Configurable

  config_accessor(:default_rating) { 1500 }
  config_accessor(:starter_games_boundary) { 20 }
  config_accessor(:pro_rating_boundary) { 2500 }

  config_accessor(:starter_k_factor) { 25 }
  config_accessor(:default_k_factor) { 15 }
  config_accessor(:pro_k_factor) { 10 }
end
