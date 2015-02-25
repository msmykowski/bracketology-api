class TeamsController < ApplicationController

  def index
    teams = Team.all
    render json: teams
  end

  def show
    team = Team.find_by name: (params[:name])
    players = team.players
    render json: players
  end

end
