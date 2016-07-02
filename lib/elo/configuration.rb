class Elo::Configuration
  include ActiveSupport::Configurable

  config_accessor(:default_rating) { 1000 }
  config_accessor(:pro_rating_boundry) { 2000 }
  config_accessor(:starter_boundry) { 20 }
end
