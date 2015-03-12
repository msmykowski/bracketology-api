class BracketController < ApplicationController

  def index
    teams = Bracket.where("team_id > 0")
    team_list = []
    teams.each do |team|
      p team
      team = {
        advance:team.advance,
        game_id:team.bracket_game_id,
        id:team.id,
        location:team.location,
        opponent:team.opponent,
        team:team.team
      }
      team_list.push(team)
    end
    render json: team_list
  end

  def populate_bracket_games
    complete_brackets = []
    brackets = Bracket.all
    brackets.each do |bracket|
      if complete_brackets.include?(bracket.location)

      else
        game_bracket = BracketGame.create!(team_one:bracket.location,team_two:bracket.opponent)
        complete_brackets.push(bracket.location)
        complete_brackets.push(bracket.opponent)
      end
    end
    bracket_games = BracketGame.all
    bracket_games.each do |game|
      team_one = Bracket.find_by(location:game.team_one)
      team_two = Bracket.find_by(location:game.team_two)
      game.update(team_one_id:team_one.team_id,team_two_id:team_two.team_id)
    end
  end

  def info
    game = Game.find(70)
    bracket = Bracket.where("")

  end

end
