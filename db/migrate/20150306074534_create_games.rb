class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :espn_id
      t.string :status
      t.integer :home_team
      t.integer :away_team
      t.integer :home_score
      t.integer :away_score
      t.timestamps
    end
  end
end
