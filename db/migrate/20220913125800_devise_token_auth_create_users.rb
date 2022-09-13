class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.1]
  def change
    
    create_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Trackable
      t.integer :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name
      t.string :last_name
      t.string :nickname
      t.string :email, limit: 60
      t.date :birthday
      t.string :cellphone
      t.string :cpf
      t.boolean :is_admin, default: false, null: false
      t.boolean :is_blocked, default: false
      t.bigint :created_by_id
      t.bigint :updated_by_id

      t.uuid :uuid, default: 'gen_random_uuid()', index: true, unique: true, where: 'active = true'

      t.boolean :active, index: true, null: false, default: true

      ## Tokens
      t.json :tokens

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
