# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  topic        :string
#  content      :text
#  sender_id    :integer
#  recipient_id :integer
#

class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages
  belongs_to :recipient, class_name: 'User', inverse_of: :received_messages

  default_scope { order('messages.created_at DESC') }
  scope :current_dialog_messages, -> (sender_id, recipient_id) { where('sender_id = :sender_id AND recipient_id = :recipient_id OR sender_id = :recipient_id AND recipient_id = :sender_id', sender_id: sender_id, recipient_id: recipient_id) }
  scope :not_read, -> { where('messages.read = false')}

  validates_presence_of :topic, :content
  validate :sender_eq_recipient
  validate :recipient_blocked

  private

  def sender_eq_recipient
    errors.add(:sender_id, :sender_eq_recipient) if sender_id == recipient_id
  end

  def recipient_blocked
    errors.add(:sender_id, :recipient_blocked) if recipient.blocked
  end
end
