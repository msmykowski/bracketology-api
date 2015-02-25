class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :img_url, :o_ppg, :o_rpg, :o_apg, :o_fg, :d_ppg, :d_rpg, :d_bpg, :d_spg, :o_ppg_rank, :o_rpg_rank, :o_apg_rank, :o_fg_rank, :d_ppg_rank, :d_rpg_rank, :d_bpg_rank, :d_spg_rank
end
