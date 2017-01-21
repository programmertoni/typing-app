class Language < ApplicationRecord
  has_many :os_projects

  validates :name, presence: true
end
