class Parameter < ActiveRecord::Base
  attr_accessible :height, :weight
  belongs_to :user
end
