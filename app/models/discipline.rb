class Discipline < ActiveRecord::Base
  attr_accessible :name

  has_many :user_disciplines
  has_many :users, through: :user_disciplines

  has_many :place_disciplines
  has_many :places, through: :place_disciplines

  validate :name, presence: true, uniqueness: true
end
