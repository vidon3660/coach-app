class User < ActiveRecord::Base

  STATUS = ["new", "active", "banned"]

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

  def is_active?
    status == "active"
  end

  def is_new?
    status == "new"
  end

  def name
    [first_name, last_name].join(" ")
  end

  def update_attributes(attributes)
    self.status = "active" if self.is_new?
    super(attributes)
  end

  private

    def validate_birth
      errors.add(:birth, "Birth date is incorrect") if birth && birth > Date.today
    end

    def set_initial_status
      self.status = "new" if status.blank?
    end

end