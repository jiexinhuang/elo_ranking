class GamesController < ApplicationController
  before_action :set_game_type
  def new
    @game = Game.new
  end

  def create
  end

  private

  def set_game_type
    @game_type = params[:game_type]
  end
end
