class PlayersController < ApplicationController

  def rank
    players = Player.order(params[:stat]).reverse
    render json: players
  end

end
