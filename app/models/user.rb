class User < ActiveRecord::Base

  STATUS = %w[new active banned]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :birth, :city, :country, :first_name, :last_name, :phone

  has_many :relationships
  has_many :contacts, through: :relationships

  has_many :invitations, class_name: "Invitation", foreign_key: "inviting_id"
  has_many :invited, through: :invitations, class_name: "User", foreign_key: "invited_id"

  has_many :invitation_requests, class_name: "Invitation", foreign_key: "invited_id"
  has_many :inviting, through: :invitation_requests, class_name: "User", foreign_key: "inviting_id"

  has_many :parameters

  has_many :traineds, class_name: "Trained", foreign_key: "coach_id"
  has_many :trained_users, through: :traineds, source: :user

  has_many :coaches, class_name: "Trained", foreign_key: "trained_id"
  has_many :coach_players, through: :coaches, source: :coach

  has_many :practise_users
  has_many :users, through: :practise_users

  has_many :prohibition_users
  has_many :prohibitions, through: :prohibition_users

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update

  validate :validate_birth

  validates :status, inclusion: STATUS

  before_validation :set_initial_status

  before_save :set_coach


  define_index do
    # fields
    indexes first_name, :sortable => true
    indexes last_name, :sortable => true
    # indexes status

    # attributes

    set_property delta: true
  end

  scope :active, -> { where("users.status = 'active'") }

  state_machine :status do
    state :new
    state :active
    state :banned

    event :active do
      transition [:new, :banned] => :active
    end
  end

  def name
    [first_name, last_name].join(" ")
  end

  private

    def validate_birth
      errors.add(:birth, "Birth date is incorrect") if birth && birth > Date.today
    end

    def	set_coach
      self.coach = true
    end

    def set_initial_status
      self.status = "new" if status.blank?
    end

end
