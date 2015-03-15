class CreateUserBrackets < ActiveRecord::Migration
  def change
    create_table :user_brackets do |t|
      t.integer :points
      t.json :bracket
      t.string :name
      t.integer :group_id
      t.integer :user_id
      t.timestamps
    end
  end
end
