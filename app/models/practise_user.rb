class PractiseUser < ActiveRecord::Base

  belongs_to :practise
  belongs_to :user

end
