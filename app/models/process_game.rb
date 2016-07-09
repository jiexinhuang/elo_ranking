class ProcessGame
  def initialize(game)
    @game = game
  end

  def process
    raise 'Cannot process already saved game' unless game.new_record?
    game.save!
  end

  private
  
  attr_reader :game
end
