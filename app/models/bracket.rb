class Bracket < ActiveRecord::Base
  has_one :team
  belongs_to :bracket_game
  validates :location, uniqueness: true

  def team
    Team.find(team_id)
  end

end
