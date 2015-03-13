class BracketGame < ActiveRecord::Base
  has_many :brackets
  validates :team_one, :team_two, uniqueness: true

  def game
    game = Game.find(game_id).serialize
    game
  end

end
