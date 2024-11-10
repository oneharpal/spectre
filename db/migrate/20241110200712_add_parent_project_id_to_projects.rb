class AddParentProjectIdToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :parent_project_id, :integer
    add_index :projects, :parent_project_id
  end
end
