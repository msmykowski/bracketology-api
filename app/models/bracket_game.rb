class BracketGame < ActiveRecord::Base
  has_many :brackets
  validates :team_one, :team_two, uniqueness: true
end
