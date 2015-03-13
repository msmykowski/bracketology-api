class Game < ActiveRecord::Base
  has_many :scores

  def home
    team = {
      team:Team.find(home_team).basic,
      score:Score.find(home_score).basic
    }
    team
  end

  def home_obj
    team = {
      team:Team.find(home_team),
      score:Score.find(home_score)
    }
    team
  end

  def away
    team = {
      team:Team.find(away_team).basic,
      score:Score.find(away_score).basic
    }
    team
  end

  def away_obj
    team = {
      team:Team.find(away_team),
      score:Score.find(away_score)
    }
    team
  end

  def game_info
    data = {
      status:status,
      score:{
        home:home[:score][:first]+home[:score][:second]+home[:score][:ot],
        away:away[:score][:first]+away[:score][:second]+away[:score][:ot]
      }
    }
    data
  end

  def serialize
    game = {
      espn_id:espn_id,
      home:home,
      away:away,
      game:game_info,
      id:id
    }
    game
  end

  def mm_serialize
    bracket_game = BracketGame.find_by(game_id:id)
    game = {
      espn_id:espn_id,
      game:game_info,
      id:id
    }
    team_one = home
    team_two = away
    team_one = away if bracket_game.team_one_id == away[:team][:id]
    team_two = home if bracket_game.team_two_id == home[:team][:id]
    if team_one[:score][:final] > team_two[:score][:final]
      team_one[:win] = true
      team_two[:win] = false
    elsif team_one[:score][:final] < team_two[:score][:final]
      team_two[:win] = true
      team_one[:win] = false
    end
    game[bracket_game[:team_one]] = team_one
    game[bracket_game[:team_two]] = team_two
    game
  end

end
