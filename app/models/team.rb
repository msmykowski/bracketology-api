class Team < ActiveRecord::Base
  has_many :players
  has_many :games
  belongs_to :bracket

  def basic
    team = {
      name:name,
      id:id,
      rank:rank,
      wins:wins,
      losses:losses
    }
    team
  end

  def games
    Game.where("home_team=? OR away_team=?",id,id)
  end

end
