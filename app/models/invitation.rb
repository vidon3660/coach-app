class Invitation < ActiveRecord::Base

  STATUS = ["accepted", "expectant", "rejected"]

  attr_accessible :status

  belongs_to :invited, class_name: "User"
  belongs_to :inviting, class_name: "User"

  validates :invited_id, presence: true
  validates :inviting_id, presence: true
  validates :status, presence: true, inclusion: STATUS

  validate :self_invitation
  validate :duplicate_invitation

  before_validation :set_status

  def make_relationship
    User.transaction do
      invited.contacts << inviting
      inviting.contacts << invited
    end
  end

  state_machine :status do
    state :accepted
    state :expectant
    state :rejected
  end

  private

    def set_status
      self.status = "expectant" if status.blank?
    end

    def self_invitation
      errors.add(:invited, "You can't send invitation to yourself.") if invited == inviting
    end

    def duplicate_invitation
      if Invitation.find_by_invited_id_and_inviting_id(invited_id, inviting_id)
        errors.add(:invited, "You've sent invitation yet.")
      end
    end

end
