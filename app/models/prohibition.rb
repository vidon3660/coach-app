class Prohibition < ActiveRecord::Base

  attr_accessible :name

  has_and_belongs_to_many :body_parts

  has_many :player_prohibitions
  has_many :players, through: :player_prohibitions

end
