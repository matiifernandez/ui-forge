class Message < ApplicationRecord
  acts_as_message
  belongs_to :chat
  validates :role, presence: true
  validates :chat, presence: true
end
