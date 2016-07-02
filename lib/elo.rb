module Elo
  def self.config
    @config ||= Elo::Configuration.new
  end

  def self.configure
    yield configuration
  end
end
