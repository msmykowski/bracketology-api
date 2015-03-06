class AddRecordToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :wins, :integer
    add_column :teams, :losses, :integer
    add_column :teams, :rank, :integer
  end
end
