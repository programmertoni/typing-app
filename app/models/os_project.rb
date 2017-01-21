class OsProject < ApplicationRecord
  belongs_to :language
  has_many   :os_pages

  validates :name, presence: true
end
