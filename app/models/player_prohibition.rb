class PlayerProhibition < ActiveRecord::Base

  attr_accessible :player_id, :prohibition_id

  belongs_to :player
  belongs_to :prohibition

end
