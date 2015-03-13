class Team < ActiveRecord::Base
  validates :espn_id, uniqueness: true
  has_many :players
  has_many :games
  belongs_to :bracket

  def basic
    team = {
      name:name,
      id:id,
      rank:rank,
      wins:wins,
      losses:losses,
      mmrank:mmrank
    }
    team
  end

  def games
    Game.where("home_team=? OR away_team=?",id,id)
  end

end
