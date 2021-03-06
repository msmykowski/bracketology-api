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

  def rank
    teams = Team.order(params[:stat]).reverse
    render json: teams
  end

end
