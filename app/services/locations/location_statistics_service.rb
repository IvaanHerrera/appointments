class Locations::LocationStatisticsService
  def call
    {
      total_per_location: total_per_location,
      unique_clients_per_location: unique_clients_per_location
    }
  end

  private

  def total_per_location
    Appointment.group(:location_id).count
  end

  def unique_clients_per_location
    Appointment.select(:location_id, :client_id).distinct
    .group(:location_id)
    .count(:client_id)
  end
end
