class Team < ActiveRecord::Base
  has_many :players

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
end
