class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :first
      t.integer :second
      t.integer :ot
      t.integer :game_id
      t.boolean :win
      t.string :team
      t.timestamps
    end
  end
end
