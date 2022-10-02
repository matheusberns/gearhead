class AddUserTimeoutToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :users_timeout, :boolean, default: false
    add_column :users, :timeout_in, :integer
  end
end
