class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.json :office_attributes, default: {}
      t.boolean :active, default: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps
    end
  end
end
