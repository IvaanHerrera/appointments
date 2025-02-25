class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :location

  before_validation :set_ends_at
  before_create :generate_code

  validates :scheduled_at, :status, presence: true
  validate :no_time_overlap


  scope :past, -> { where("scheduled_at < ?", Time.current) }
  scope :current, -> { where("scheduled_at BETWEEN ? AND ?", Time.current, Time.current.end_of_day) }
  scope :future, -> { where("scheduled_at > ?", Time.current) }

  private

  def generate_code
    self.code = AppointmentCodeService.new(self).call
  end

  def set_ends_at
    self.ends_at = scheduled_at + duration.minutes if scheduled_at.present? && duration.present?
  end

  def no_time_overlap
    return unless scheduled_at && ends_at

    if overlapping_appointments.exists?
      errors.add(:base, "The appointment overlaps with an existing one.")
    end
  end

  def overlapping_appointments
    Appointment.where(location_id: location_id)
               .where.not(id: id)
               .where("scheduled_at < ? AND ends_at > ?", ends_at, scheduled_at)
  end
end
