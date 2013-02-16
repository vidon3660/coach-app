class Invitation < ActiveRecord::Base

  STATUS = ["accepted", "expectant", "rejected"]

  attr_accessible :status, :friend

  belongs_to :invited, class_name: "User"
  belongs_to :inviting, class_name: "User"

  validates :invited_id, presence: true
  validates :inviting_id, presence: true
  validates :status, presence: true, inclusion: STATUS

  validate :self_invitation
  validate :duplicate_invitation

  before_validation :set_status

  state_machine :status do
    state :accepted
    state :expectant
    state :rejected

    event :accepted do
      transition [:expectant] => :accepted
    end
  end

  default_scope { order("created_at desc") }

  def make_relationship
    ActiveRecord::Base.transaction do
      inviting.trained_users  << invited  if training
      inviting.direct_friends << invited  if friend
      self.accepted
    end
  end

  private

    def set_status
      self.status = "expectant" if status.blank?
    end

    def self_invitation
      errors.add(:invited, "You can't send invitation to yourself.") if invited == inviting
    end

    def duplicate_invitation
      if self.new_record?
        invitation = Invitation.find_by_invited_id_and_inviting_id(invited_id, inviting_id)
        if invitation
          if invitation.training.blank? && self.training.present?

          else
            errors.add(:invited, "You've sent invitation yet.")
          end
        end
      end
    end

end
