class PlaceDiscipline < ActiveRecord::Base
  attr_accessible :description

  belongs_to :discipline
  belongs_to :place
end