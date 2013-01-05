class User < ActiveRecord::Base

  ROLES  = %w[admin coach user]
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
  before_validation :set_roles

  after_save :set_player

  state_machine :status do
    state :new
    state :active
    state :banned

    event :active do
      transition [:new, :banned] => :active
    end
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is_coach?
    roles.include?("coach")
  end

  private

    def set_player
      create_player unless player
    end

    def set_initial_status
      self.status = "new" if status.blank?
    end

    def set_roles
      self.roles = ROLES
    end

end