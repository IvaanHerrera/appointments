# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear Tables
Organization.destroy_all
User.destroy_all
Client.destroy_all
Location.destroy_all
Appointment.destroy_all

organization = Organization.create!(name: 'Example Organization')

# Create a new users
admin = User.create!(
  name: 'Administrator',
  email: 'admin@example.com',
  password: 'password',
  organization_id: organization.id
)

# Create a new Client
client = Client.create!(
  first_name: 'Martin', 
  last_name: 'Fowler',
  email: 'client@example.com',
  telephone: '1234567890',
  address: '123 Main St',
  organization_id: organization.id,
  user_id: admin.id
)

# Create a Location
location = Location.create!(
  name: 'Consultorio San Cristobal',
  address: '456 Elm St',
  organization_id: organization.id,
)

appointment_date = Time.zone.now

# Create an Appointment
appointment = Appointment.create!(
  user_id: admin.id,
  client_id: client.id,
  location_id: location.id,
  scheduled_at: appointment_date,
  end_time: appointment_date + 1.hour,
  status: 'pending'
)