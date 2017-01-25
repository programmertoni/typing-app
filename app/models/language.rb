class Language < ApplicationRecord
  has_many :os_projects, dependent: :destroy

  validates :name, presence: true
end
