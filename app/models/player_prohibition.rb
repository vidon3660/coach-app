class PlayerProhibition < ActiveRecord::Base

  belongs_to :player
  belongs_to :prohibition

end
