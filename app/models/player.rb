class Player < ActiveRecord::Base
  validates :name, uniqueness: {scope: :team_id}
  belongs_to :team
end
