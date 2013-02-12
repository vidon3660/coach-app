class Event < ActiveRecord::Base
  attr_accessible :end_at, :start_at, :type, :description

  has_and_belongs_to_many :places
  has_and_belongs_to_many :trainings
  has_and_belongs_to_many :users

end
