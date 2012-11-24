class User < ActiveRecord::Base

  STATUS = ["new", "active"]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :address, :birth, :country, :city, :first_name, :last_name,
                  :status, :phone
  # attr_accessible :title, :body

  validate :status, inclusion: STATUS

  after_create :set_initial_status

  def name
    "#{first_name} #{last_name}"
  end

  def is_new?
    status == "new"
  end

  private

    def set_initial_status
      update_attribute(:status, "new")
    end
end