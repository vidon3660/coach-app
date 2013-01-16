class Trained < ActiveRecord::Base

  belongs_to :player, class_name: "Player", foreign_key: "trained_id"
  belongs_to :coach, class_name: "Player", foreign_key: "coach_id"

end
