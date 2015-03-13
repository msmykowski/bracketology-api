class AddAdvanceToBracketGame < ActiveRecord::Migration
  def change
    add_column :bracket_games, :advance, :string
  end
end
