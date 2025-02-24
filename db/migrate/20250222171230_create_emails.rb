class CreateEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :emails do |t|
      t.references :emailable, polymorphic: true, null: false
      t.string :address, null: false
      t.boolean :primary, null: false, default: false

      t.timestamps
    end
  end
end
