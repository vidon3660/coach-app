class ProhibitionUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :prohibition

end
