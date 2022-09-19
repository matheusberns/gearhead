class CreateModels < ActiveRecord::Migration[7.0]
  def change
    create_table :models do |t|
      t.string :name, limit: 255, null: false, index: true
      t.integer :brand_type, null: false, index: true

      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :updated_by, index: true, foreign_key: { to_table: :users }

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
