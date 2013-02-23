class Place < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :events
  has_one :location

end
