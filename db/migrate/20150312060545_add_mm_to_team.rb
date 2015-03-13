class AddMmToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :mmid, :string
    add_column :teams, :mmrank, :integer
  end
end
