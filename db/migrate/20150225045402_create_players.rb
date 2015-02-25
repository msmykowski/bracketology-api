class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :gp
      t.string :min
      t.string :ppg
      t.string :rpg
      t.string :apg
      t.string :spg
      t.string :bpg
      t.string :tpg
      t.string :fg
      t.string :ft
      t.string :threep
      t.integer :team_id

      t.timestamps
    end
  end
end
