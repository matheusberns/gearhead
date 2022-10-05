class CreateOptionals < ActiveRecord::Migration[7.0]
  def change
    create_table :optionals do |t|
      t.string :name, limit: 50

      t.uuid :uuid, index: true, null: false, default: 'uuid_generate_v4()', unique: true
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :updated_by, index: true, foreign_key: { to_table: :users }

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
