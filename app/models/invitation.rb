class Invitation < ActiveRecord::Base

  belongs_to :invited, class_name: "User"
  belongs_to :inviting, class_name: "User"

  validates :invited_id, presence: true
  validates :inviting_id, presence: true

  validate :self_invitation
  validate :duplicate_invitation

  private

    def self_invitation
      errors.add(:invited, "You can't send invitation to yourself.") if invited == inviting
    end

    def duplicate_invitation
      if Invitation.find_by_invited_id_and_inviting_id(invited_id, inviting_id)
        errors.add(:invited, "You've sent invitation yet.")
      end
    end

end
