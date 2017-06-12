class RenameUserToContact < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :contacts
  end
end
