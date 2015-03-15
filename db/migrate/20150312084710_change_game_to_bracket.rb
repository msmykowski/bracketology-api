class ChangeGameToBracket < ActiveRecord::Migration
  def change
    rename_column :brackets, :game_id, :bracket_game_id
  end
end
