class Training < ActiveRecord::Base

  belongs_to :user
  belongs_to :coach, class_name: "User", foreign_key: "coach_id"

  has_and_belongs_to_many :events

  scope :open,   -> { where("close_at IS NULL") }
  scope :closed, -> { where("close_at IS NOT NULL") }

end
