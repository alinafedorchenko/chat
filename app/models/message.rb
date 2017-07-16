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

  validates_presence_of :topic, :content, :sender, :recipient
  validate :sender_eq_recipient

  private

  def sender_eq_recipient
    errors.add(:sender_id, :sender_eq_recipient) if sender_id == recipient_id
  end
end
