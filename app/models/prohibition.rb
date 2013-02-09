class Prohibition < ActiveRecord::Base

  attr_accessible :name

  has_and_belongs_to_many :body_parts
  has_and_belongs_to_many :practises

  has_many :prohibition_users
  has_many :users, through: :prohibition_users

end
