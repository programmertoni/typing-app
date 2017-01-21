class CreateOsProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :os_projects do |t|
      t.string     :name
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
