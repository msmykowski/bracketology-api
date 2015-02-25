class TeamsController < ApplicationController

  def index
    teams = Team.all
    render json: teams
  end

  def show
    team = Team.find(params[:id])
    players = team.players
    render json: players
  end

end
