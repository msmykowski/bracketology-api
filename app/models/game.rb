class Game < ActiveRecord::Base
  has_many :scores

  def home
    team = {
      team:Team.find(home_team).basic,
      score:Score.find(home_score).basic
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

end
