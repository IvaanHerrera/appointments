require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    it 'is valid with a first name and last name' do
      client = build(:client, first_name: 'Martin', last_name: 'Fowler')
      expect(client).to be_valid
    end

    it 'is not valid without a first name' do
      client = build(:client, first_name: nil, last_name: 'Fowler')
      expect(client).not_to be_valid
    end

    it 'is not valid without a last name' do
      client = build(:client, first_name: 'Martin', last_name: nil)
      expect(client).not_to be_valid
    end
  end

  describe 'methods' do
    it 'returns the full name as a concatenation of first and last name' do
      client = build(:client, first_name: 'Martin', last_name: 'Fowler')
      expect(client.full_name).to eq('Martin Fowler')
    end

    it 'returns an empty string if both first and last name are empty' do
      client = build(:client, first_name: '', last_name: '')
      expect(client.full_name).to eq('')
    end
  end

  describe 'associations' do
    it 'has many appointments' do
      client = create(:client)
      appointment = create(:appointment, client: client)
      expect(client.appointments).to include(appointment)
    end

    it 'destroys associated appointments when destroyed' do
      client = create(:client)
      appointment = create(:appointment, client: client)
      expect { client.destroy }.to change { Appointment.count }.by(-1)
    end

    it 'has many addresses' do
      client = create(:client)
      address = create(:address, addressable: client)
      expect(client.addresses).to include(address)
    end

    it 'destroys associated addresses when destroyed' do
      client = create(:client)
      address = create(:address, addressable: client)
      expect { client.destroy }.to change { Address.count }.by(-1)
    end

    it 'has many emails' do
      client = create(:client)
      email = create(:email, emailable: client)
      expect(client.emails).to include(email)
    end

    it 'destroys associated emails when destroyed' do
      client = create(:client)
      email = create(:email, emailable: client)
      expect { client.destroy }.to change { Email.count }.by(-1)
    end
  end
end
