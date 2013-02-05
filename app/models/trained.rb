class Trained < ActiveRecord::Base

  belongs_to :user, class_name: "User", foreign_key: "trained_id"
  belongs_to :coach, class_name: "User", foreign_key: "coach_id"

end
