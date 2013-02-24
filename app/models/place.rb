class Place < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :events

  has_many :place_disciplines
  has_many :disciplines, through: :place_disciplines

  has_one :location

end
