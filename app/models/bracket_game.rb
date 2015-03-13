class BracketGame < ActiveRecord::Base
  has_many :brackets
  validates :team_one, :team_two, uniqueness: true

  def game
    if game_id
      game = Game.find(game_id).mm_serialize
    else
      game = nil
    end
    game
  end

  def check_winner
    one = Bracket.find_by(location:team_one)
    two = Bracket.find_by(location:team_two)
    if game
      if(game[:game][:status].match("Final"))
        if game[one.location][:win]
          one.update(win:true)
          two.update(win:false)
          winner = one.team_id
        elsif game[two.location][:win]
          one.update(win:false)
          two.update(win:true)
          winner = two.team_id
        end
        if winner
          Bracket.find_by(location:one.advance).update(team_id:winner)
          bracket_game = BracketGame.where("team_one = ? OR team_two = ?", one.advance, one.advance)[0]
          if bracket_game.team_one == one.advance
            bracket_game.update(team_one_id:winner)
          elsif bracket_game.team_two == one.advance
            bracket_game.update(team_two_id:winner)
          end
        end
      end
    end
    bracket_game || nil
  end

end
