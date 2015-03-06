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

  def serialize
    game = {
      espn_id:espn_id,
      home:home,
      away:away,
      id:id
    }
    game
  end

end
