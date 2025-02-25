require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:location) { create(:location) }
  let(:appointment) { create(:appointment, user: user, client: client, location: location) }

  describe "validations" do
    it "is a valid appointment" do
      expect(appointment).to be_valid
    end

    it "is not valid without a scheduled_at" do
      appointment.scheduled_at = nil
      expect(appointment).not_to be_valid
    end

    it "is not valid without a status" do
      appointment.status = nil
      expect(appointment).not_to be_valid
    end

    it "is not valid with overlapping appointments" do
      overlapping_appointment = build(:appointment,
        scheduled_at: appointment.scheduled_at + 10.minutes, ends_at: appointment.ends_at + 10.minutes, location: location, user: user, client: client
      )
      expect(overlapping_appointment).not_to be_valid
    end
  end

  describe "callbacks" do
    it "sets ends_at before save" do
      appointment = build(:appointment, scheduled_at: "2025-02-24 10:00:00", duration: 30)
      appointment.save
      expect(appointment.ends_at).to eq(appointment.scheduled_at + 30.minutes)
    end
  end

  describe "methods" do
    it "should generate a unique appointment code" do
      appointment = create(:appointment)
      expect(appointment.code).to be_present
    end
  end
end
