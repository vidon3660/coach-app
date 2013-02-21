class UserDiscipline < ActiveRecord::Base
  attr_accessible :is_coach

  belongs_to :discipline
  belongs_to :user

end
