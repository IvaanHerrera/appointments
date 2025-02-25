require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      location = build(:location, name: 'Test Location')
      expect(location).to be_valid
    end

    it 'is not valid without a name' do
      location = build(:location, name: nil)
      expect(location).not_to be_valid
    end
  end

  describe 'methods' do
    it 'returns the name correctly' do
      location = build(:location, name: 'Test Location')
      expect(location.name).to eq('Test Location')
    end
  end

  describe 'associations' do
    it 'has many appointments' do
      location = create(:location)
      appointment = create(:appointment, location: location)
      expect(location.appointments).to include(appointment)
    end

    it 'destroys associated appointments when destroyed' do
      location = create(:location)
      appointment = create(:appointment, location: location)
      expect { location.destroy }.to change { Appointment.count }.by(-1)
    end

    it 'has many addresses' do
      location = create(:location)
      address = create(:address, addressable: location)
      expect(location.addresses).to include(address)
    end

    it 'destroys associated addresses when destroyed' do
      location = create(:location)
      address = create(:address, addressable: location)
      expect { location.destroy }.to change { Address.count }.by(-1)
    end
  end

  describe 'nested attributes' do
    it 'can accept nested attributes for addresses' do
      location = create(:location, addresses_attributes: [
        { street: 'Test Street Name', city: 'Test City', state: 'Test State', country: 'MX', zip_code: '123' }
      ])
      expect(location.addresses.count).to eq(1)
      expect(location.addresses.first.street).to eq('Test Street Name')
    end

    it 'is not valid without required attributes for addresses' do
      location = build(:location, addresses_attributes: [
        { street: 'Test Street Name', city: 'Test City' }
      ])
      expect(location).not_to be_valid
    end

    it 'can destroy addresses through nested attributes' do
      location = create(:location, addresses_attributes: [
        { street: 'Test Street Name', city: 'Test City', state: 'Test State', country: 'MX', zip_code: '123' }
      ])
      expect(location.addresses.count).to eq(1)

      location.update(addresses_attributes: [ { id: location.addresses.first.id, _destroy: '1' } ])
      expect(location.addresses.count).to eq(0)
    end
  end
end
