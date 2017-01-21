class Book < ApplicationRecord
  has_many :book_pages

  validates :name, presence: true
end
