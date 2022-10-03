class RemoveLastNameToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :last_name
  end
end
