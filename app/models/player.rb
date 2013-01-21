class Player < ActiveRecord::Base

  attr_accessible :address, :birth, :city, :country, :first_name, :last_name, :phone

  belongs_to :user

  has_many :parameters

  has_many :traineds, class_name: "Trained", foreign_key: "coach_id"
  has_many :trained_players, through: :traineds, source: :player

  has_many :coaches, class_name: "Trained", foreign_key: "trained_id"
  has_many :coach_players, through: :coaches, source: :coach

  has_many :player_practises
  has_many :practises, through: :player_practises

  has_many :player_prohibitions
  has_many :prohibitions, through: :player_prohibitions

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update

  validate :validate_birth

  define_index do
    # fields
    indexes first_name, :sortable => true
    indexes last_name, :sortable => true
    # indexes status

    # attributes

    set_property delta: true
  end

  scope :active, -> { joins(:user).where("users.status = 'active'") }

  def name
    [first_name, last_name].join(" ")
  end

  private

    def validate_birth
      errors.add(:birth, "Birth date is incorrect") if birth && birth > Date.today
    end

end
