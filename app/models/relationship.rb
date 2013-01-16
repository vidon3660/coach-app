class Relationship < ActiveRecord::Base

  attr_accessible :training

  belongs_to :user
  belongs_to :contact, class_name: "User"

  validates :user_id, presence: true
  validates :contact_id, presence: true

end
