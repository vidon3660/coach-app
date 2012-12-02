class User < ActiveRecord::Base

  ROLES = %w[admin coach user]
  STATUS = %w[new active banned]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :address, :birth, :country, :city, :first_name, :last_name,
                  :phone
  # attr_accessible :title, :body

  validates :status, inclusion: STATUS
  validate :validate_birth

  before_validation :set_initial_status
  before_validation :set_roles

  def active!
    self.update_attribute(:status, "active")
  end

  def active?
    status == "active"
  end

  def new?
    status == "new"
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def name
    [first_name, last_name].join(" ")
  end

  private

    def validate_birth
      errors.add(:birth, "Birth date is incorrect") if birth && birth > Date.today
    end

    def set_initial_status
      self.status = "new" if status.blank?
    end

    def set_roles
      self.roles = ROLES
    end

end