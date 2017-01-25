class AddOrderToOsProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :os_projects, :order, :integer
  end
end
