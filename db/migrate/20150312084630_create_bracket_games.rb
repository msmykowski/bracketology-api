class CreateBracketGames < ActiveRecord::Migration
  def change
    create_table :bracket_games do |t|
      t.string :team_one
      t.string :team_two
      t.integer :team_one_id
      t.integer :team_two_id
      t.integer :game_id
    end
  end
end
