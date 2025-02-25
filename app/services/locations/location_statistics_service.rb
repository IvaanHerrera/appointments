class Locations::LocationStatisticsService
  def self.call
    {
      total_per_location: total_per_location,
      unique_clients_per_location: unique_clients_per_location
    }
  end

  private

  def self.total_per_location
    Appointment.group(:location_id).count
  end

  def self.unique_clients_per_location
    unique_clients = Appointment.select(:location_id, :client_id).distinct
    .group(:location_id)
    .count(:client_id) 
  end
end
