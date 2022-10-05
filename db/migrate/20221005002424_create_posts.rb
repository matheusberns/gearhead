class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, limit: 90, null: false, index: true
      t.text :description, limit: 6000, null: false, index: true
      t.integer :brand_type, null: false, index: true
      t.datetime :model_year, null: false, index: true
      t.integer :gearbox_type
      t.integer :fuel_type
      t.integer :steering_type
      t.boolean :with_gnv
      t.boolean :vehicle_type
      t.integer :mileage
      t.integer :door_type
      t.integer :end_plate_type
      t.integer :color_type
      t.boolean :accept_exchange
      t.string :cep
      t.integer :category_type
      t.float :price
      t.uuid :uuid, index: true, null: false, default: 'uuid_generate_v4()', unique: true

      t.references :model, index: true, foreign_key: { to_table: :models }
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.references :updated_by, index: true, foreign_key: { to_table: :users }

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
