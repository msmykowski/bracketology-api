class BracketController < ApplicationController

  def index
    teams = Bracket.where("team_id > 0")
    team_list = []
    teams.each do |team|
      team = {
        advance:team.advance,
        game_id:team.bracket_game_id,
        id:team.id,
        location:team.location,
        opponent:team.opponent,
        team:team.team.basic,
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
        game_bracket = BracketGame.new(team_one:bracket.location,team_two:bracket.opponent,advance:bracket.advance)
        complete_brackets.push(bracket.location)
        complete_brackets.push(bracket.opponent)
        game_bracket.save
      end
    end
    bracket_games = BracketGame.all
    bracket_games.each do |game|
      team_one = Bracket.find_by(location:game.team_one)
      team_two = Bracket.find_by(location:game.team_two)
      game.update(team_one_id:team_one.team_id,team_two_id:team_two.team_id)
    end
    render json: bracket_games
  end

  def games
    games = BracketGame.all
    game_list = {}
    games.each do |game|
      if game.game_id
        game.game
        game_data = Game.find(game.game_id)
        score_data = game_data.mm_serialize
        game_id = "#{game.team_one}-#{game.team_two}"
      elsif (game.team_one_id || game.team_two_id)
        score_data = pending_game game
        game_id = "#{game.team_one}-#{game.team_two}"
      end
      game_list[game_id] = score_data
    end
    render json: game_list
  end

  def pending_game bracket_game
    game = {
      bracket_game[:team_one] => {},
      bracket_game[:team_two] => {}
    }
    game[bracket_game[:team_one]][:team] = Team.find(bracket_game[:team_one_id]).basic if bracket_game[:team_one_id]
    game[bracket_game[:team_two]][:team] = Team.find(bracket_game[:team_two_id]).basic if bracket_game[:team_two_id]
    game[:game] = {
      status:""
    }
    game
  end

  def make_bracket
    seeds = [
      {location:"W1A",rank:"1", name:""},
      {location:"W1B",rank:"16",name:""},
      {location:"W1C",rank:"2", name:""},
      {location:"W1D",rank:"15",name:""},
      {location:"W1E",rank:"3", name:""},
      {location:"W1F",rank:"14",name:""},
      {location:"W1G",rank:"4", name:""},
      {location:"W1H",rank:"13",name:""},
      {location:"W1I",rank:"5", name:""},
      {location:"W1J",rank:"12",name:""},
      {location:"W1K",rank:"6", name:""},
      {location:"W1L",rank:"11",name:""},
      {location:"W1M",rank:"7", name:""},
      {location:"W1N",rank:"10",name:""},
      {location:"W1O",rank:"8", name:""},
      {location:"W1P",rank:"9", name:""},
      {location:"M1A",rank:"1", name:""},
      {location:"M1B",rank:"16",name:""},
      {location:"M1C",rank:"2", name:""},
      {location:"M1D",rank:"15",name:""},
      {location:"M1E",rank:"3", name:""},
      {location:"M1F",rank:"14",name:""},
      {location:"M1G",rank:"4", name:""},
      {location:"M1H",rank:"13",name:""},
      {location:"M1I",rank:"5", name:""},
      {location:"M1J",rank:"12",name:""},
      {location:"M1K",rank:"6", name:""},
      {location:"M1L",rank:"11",name:""},
      {location:"M1M",rank:"7", name:""},
      {location:"M1N",rank:"10",name:""},
      {location:"M1O",rank:"8", name:""},
      {location:"M1P",rank:"9", name:""},
      {location:"E1A",rank:"1", name:""},
      {location:"E1B",rank:"16",name:""},
      {location:"E1C",rank:"2", name:""},
      {location:"E1D",rank:"15",name:""},
      {location:"E1E",rank:"3", name:""},
      {location:"E1F",rank:"14",name:""},
      {location:"E1G",rank:"4", name:""},
      {location:"E1H",rank:"13",name:""},
      {location:"E1I",rank:"5", name:""},
      {location:"E1J",rank:"12",name:""},
      {location:"E1K",rank:"6", name:""},
      {location:"E1L",rank:"11",name:""},
      {location:"E1M",rank:"7", name:""},
      {location:"E1N",rank:"10",name:""},
      {location:"E1O",rank:"8", name:""},
      {location:"E1P",rank:"9", name:""},
      {location:"S1A",rank:"1", name:""},
      {location:"S1B",rank:"16",name:""},
      {location:"S1C",rank:"2", name:""},
      {location:"S1D",rank:"15",name:""},
      {location:"S1E",rank:"3", name:""},
      {location:"S1F",rank:"14",name:""},
      {location:"S1G",rank:"4", name:""},
      {location:"S1H",rank:"13",name:""},
      {location:"S1I",rank:"5", name:""},
      {location:"S1J",rank:"12",name:""},
      {location:"S1K",rank:"6", name:""},
      {location:"S1L",rank:"11",name:""},
      {location:"S1M",rank:"7", name:""},
      {location:"S1N",rank:"10",name:""},
      {location:"S1O",rank:"8", name:""},
      {location:"S1P",rank:"9", name:""}
    ]
    seeds.each do |seed|
      team = Team.find_by(name:seed[:name])
      team.update(mmrank:seed[:rank],mmid:seed[:location])
      bracket = Bracket.find_by(location:seed[:location]).update(team_id:team.id)
    end
    populate_bracket_games
  end

end
