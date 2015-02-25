class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :img_url
      t.string :o_ppg
      t.string :o_rpg
      t.string :o_apg
      t.string :o_fg
      t.string :d_ppg
      t.string :d_rpg
      t.string :d_bpg
      t.string :d_spg
      t.string :o_ppg_rank
      t.string :o_rpg_rank
      t.string :o_apg_rank
      t.string :o_fg_rank
      t.string :d_ppg_rank
      t.string :d_rpg_rank
      t.string :d_bpg_rank
      t.string :d_spg_rank

      t.timestamps
    end
  end
end
