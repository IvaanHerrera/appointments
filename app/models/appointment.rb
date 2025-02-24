class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :location

  validates :scheduled_at, :status, presence: true
  before_create :generate_code

  scope :past, -> { where("scheduled_at < ?", Time.current) }
  scope :current, -> { where("scheduled_at BETWEEN ? AND ?", Time.current, Time.current.end_of_day) }
  scope :future, -> { where("scheduled_at > ?", Time.current) }

  private

  def generate_code
    self.code = AppointmentCodeService.new(self).call
  end
end
