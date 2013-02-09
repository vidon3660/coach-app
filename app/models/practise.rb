class Practise < ActiveRecord::Base

  attr_accessible :name

  has_and_belongs_to_many :prohibitions

  has_many :practise_users
  has_many :users, through: :practise_users

end
