class AddFieldsToAppointments < ActiveRecord::Migration[8.0]
  def change
    add_column :appointments, :duration, :integer, default: 30, null: false
    add_column :appointments, :arrival_at, :datetime
    add_column :appointments, :canceled_at, :datetime
    add_column :appointments, :ends_at, :datetime
  end
end
