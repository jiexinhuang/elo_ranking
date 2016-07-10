class GamesController < ApplicationController
  before_action :set_game_type
  def new
    @form = GameForm.new(game_type: @game_type)
  end

  def create
    @form = GameForm.new(game_form_params)
    @form.save!

    redirect_to "/#{@game_type}"
  end

  private

  def game_form_params
    params[:game_form].merge(
      game_type: @game_type,
      home_player_user: @signed_in_user
    )
  end

  def set_game_type
    @game_type = params[:game_type]
  end
end
