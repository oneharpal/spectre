class AddRankAndStatusToNote < ActiveRecord::Migration[7.2]
  def change
    add_column :notes, :status, :integer
    add_column :notes, :rank, :integer
  end
end
