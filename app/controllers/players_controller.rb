class PlayersController < ApplicationController
  def index
    @game_type = params[:game_type]
    @players = Player.where(game_type: @game_type).order('rating desc').includes(:user)
  end
end
