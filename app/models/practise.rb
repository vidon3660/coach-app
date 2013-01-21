class Practise < ActiveRecord::Base

  attr_accessible :name

  has_and_belongs_to_many :prohibitions

  has_many :player_practises
  has_many :players, through: :player_practises

end
