class AppointmentService
  def self.create(params)
    appointment = Appointment.new(params)
    appointment.save
    appointment
  end

  def self.filtered_appointments(params)
    start_date = params[:start_date]&.to_date || 1.month.ago.to_date
    end_date = params[:end_date]&.to_date || Date.today

    Appointment.includes(:user, :client, :location)
               .where(scheduled_at: start_date.beginning_of_day..end_date.end_of_day)
               .order(:scheduled_at)
  end

  def self.update(appointment, params)
    appointment.update(params)
  end

  def self.destroy(appointment)
    appointment.destroy
  end
end
