class AddImmortalToProject < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :immortal, :boolean
  end
end