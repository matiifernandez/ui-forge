class Component < ApplicationRecord
  belongs_to :project
  has_one :chat, dependent: :destroy
  validates :name, presence: true, uniqueness: {scope: :project_id}
end
