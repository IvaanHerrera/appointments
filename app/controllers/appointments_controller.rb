class AppointmentsController < ApplicationController
  protect_from_forgery except: :edit

  before_action :set_appointment, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @appointments = AppointmentService.filtered_appointments(params)
    @statistics = AppointmentStatisticsService.call
  end

  def show; end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = AppointmentService.create(appointment_params)
    if @appointment.persisted?
      redirect_to @appointment, notice: 'Appointment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if AppointmentService.update(@appointment, appointment_params)
      redirect_to @appointment, notice: 'Appointment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    AppointmentService.destroy(@appointment)
    redirect_to appointments_url, notice: 'Appointment was successfully destroyed.'
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :client_id, :location_id, :scheduled_at, :status)
  end
end
