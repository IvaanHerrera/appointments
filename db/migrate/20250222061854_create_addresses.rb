class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :country, null: false
      t.boolean :primary, null: false, default: false

      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
