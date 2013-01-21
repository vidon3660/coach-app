class User < ActiveRecord::Base

  STATUS = %w[new active banned]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :player

  has_many :relationships
  has_many :contacts, through: :relationships

  has_many :invitations, class_name: "Invitation", foreign_key: "inviting_id"
  has_many :invited, through: :invitations, class_name: "User", foreign_key: "invited_id"

  has_many :invitation_requests, class_name: "Invitation", foreign_key: "invited_id"
  has_many :inviting, through: :invitation_requests, class_name: "User", foreign_key: "inviting_id"

  validates :status, inclusion: STATUS

  before_validation :set_initial_status

  before_save :set_coach
  after_save :set_player

  state_machine :status do
    state :new
    state :active
    state :banned

    event :active do
      transition [:new, :banned] => :active
    end
  end

  private

    def	set_coach
      self.coach = true
    end

    def set_player
      create_player unless player
    end

    def set_initial_status
      self.status = "new" if status.blank?
    end

end
