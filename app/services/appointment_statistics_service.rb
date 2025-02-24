class AppointmentStatisticsService
  def self.call
    {
      current_appointments: Appointment.current.count,
      past_appointments: Appointment.past.count,
      future_appointments: Appointment.future.count
    }
  end
end
