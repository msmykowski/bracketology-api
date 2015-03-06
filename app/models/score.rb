class Score < ActiveRecord::Base
  belongs_to :game

  def basic
    score = {
      first:first,
      second:second,
      ot:ot,
      win:win
    }
    score
  end

end
