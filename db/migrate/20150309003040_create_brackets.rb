class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.integer :game_id
      t.integer :team_id
      t.string :location
      t.string :advance
      t.string :opponent
      t.boolean :win
      t.timestamps
    end
  end
end
