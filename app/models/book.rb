class Book < ApplicationRecord
  has_many :book_pages, dependent: :destroy

  validates :name, presence: true
end
