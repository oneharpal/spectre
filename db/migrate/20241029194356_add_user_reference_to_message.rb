class AddUserReferenceToMessage < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :user, null: true, foreign_key: true
  end
end
