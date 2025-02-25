class AppointmentCodeService
  attr_reader :appointment

  MULTIPLIER = 17
  MODULUS = 26
  ASCII_A = 65

  def initialize(appointment)
    @appointment = appointment
  end

  def call
    "#{generate_checksum}#{generate_letter}"
  end

  private

  def checksum
    @checksum ||= sum_digits(appointment.client.normalized_id) +
                  sum_digits(appointment.user.normalized_id) +
                  sum_digits(appointment.location.normalized_id) +
                  sum_digits(scheduled_at_fragment)
  end

  def generate_checksum
    (checksum * MULTIPLIER).to_s.rjust(6, "0")
  end

  def generate_letter
    (checksum % MODULUS + ASCII_A).chr
  end

  def sum_digits(str)
    str.chars.map(&:to_i).sum
  end

  def scheduled_at_fragment
    appointment.scheduled_at.strftime("%Y%m%d%H%M")[-4..]
  end
end
