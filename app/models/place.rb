class Place < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :events

end
