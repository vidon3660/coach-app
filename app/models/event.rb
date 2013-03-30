class Event < ActiveRecord::Base
  attr_accessible :name, :description, :start_at, :end_at, :event_type

  belongs_to :place

  has_and_belongs_to_many :trainings
  has_and_belongs_to_many :users
end
