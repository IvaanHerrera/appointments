class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.string :status
      t.string :code

      t.timestamps
    end
  end
end
