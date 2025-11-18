class Project < ApplicationRecord
  belongs_to :user
  has_many :components, dependent: :destroy
  validates :title, presence: true, uniqueness: {scope: :user_id}, length: {maximum: 50}
  validates :description, presence: true
end
