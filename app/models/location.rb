class Location < ActiveRecord::Base
  attr_accessible :city

  belongs_to :place
end
