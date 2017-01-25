class OsProject < ApplicationRecord
  belongs_to :language
  has_many   :os_pages, dependent: :destroy

  validates :name, presence: true
end
