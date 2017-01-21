class CreateBookPages < ActiveRecord::Migration[5.0]
  def change
    create_table :book_pages do |t|
      t.integer    :number
      t.text       :content
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
