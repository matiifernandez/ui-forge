class Chat < ApplicationRecord
  acts_as_chat
  belongs_to :component
  has_many :messages, dependent: :destroy
end
