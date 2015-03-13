class Bracket < ActiveRecord::Base
  has_one :team
  belongs_to :bracket_game
  validates :location, uniqueness: true

  def team
    Team.find(team_id)
  end

  def bracket_game
    Game.find(BracketGame.find_by("(team_one=? AND team_two=?) OR (team_one=? AND team_two=?)",location,opponent,opponent,location).game_id)
  end

end
