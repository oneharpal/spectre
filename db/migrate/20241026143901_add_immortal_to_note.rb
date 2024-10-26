class AddImmortalToNote < ActiveRecord::Migration[7.2]
  def change
    add_column :notes, :immortal, :boolean
  end
end
