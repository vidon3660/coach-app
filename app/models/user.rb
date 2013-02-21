class User < ActiveRecord::Base

  STATUS = %w[new active banned]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :birth, :city, :country, :first_name, :last_name, :phone,
                  :avatar, :avatar_cache


  # Contacts
  has_many :invitations, foreign_key: "inviting_id"
  has_many :invitation_requests, class_name: "Invitation", foreign_key: "invited_id"
  has_many :invited_users, through: :invitations, source: :invited
  has_many :inviting_users, through: :invitation_requests, source: :inviting

  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :direct_friends, :through => :friendships, :source => :friend
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :trainings, foreign_key: "coach_id"
  has_many :inverse_trainings, class_name: "Training", foreign_key: "user_id"
  has_many :trained_users, through: :trainings, source: :user
  has_many :user_coaches, through: :inverse_trainings, source: :coach

  def friends
    direct_friends | inverse_friends
  end

  # User
  has_and_belongs_to_many :events

  has_many :user_disciplines
  has_many :disciplines, through: :user_disciplines

  has_many :parameters

  has_many :practise_users
  has_many :users, through: :practise_users

  has_many :prohibition_users
  has_many :prohibitions, through: :prohibition_users

  # validations

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update

  validate :validate_birth

  validates :status, inclusion: STATUS

  before_validation :set_initial_status

  before_save :set_coach

  has_private_messages

  mount_uploader :avatar, AvatarUploader

  define_index do
    # fields
    indexes first_name, :sortable => true
    indexes last_name, :sortable => true
    # indexes status

    # attributes

    set_property delta: true
  end

  # TODO: check this!
  scope :active,  -> { where("users.status = 'active'") }
  scope :coaches, -> { active.where(coach: true) }

  state_machine :status do
    state :new
    state :active
    state :banned

    event :active do
      transition [:new, :banned] => :active
    end
  end

  def coach?
    self.coach
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
