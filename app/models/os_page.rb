class OsPage < ApplicationRecord
  belongs_to :os_project

  validates :content, presence: true
end
