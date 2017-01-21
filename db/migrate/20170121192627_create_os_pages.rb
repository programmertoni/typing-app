class CreateOsPages < ActiveRecord::Migration[5.0]
  def change
    create_table :os_pages do |t|
      t.integer    :number
      t.text       :content
      t.references :os_project, foreign_key: true

      t.timestamps
    end
  end
end
