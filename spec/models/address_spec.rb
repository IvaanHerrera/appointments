require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:location) { create(:location) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      address = build(:address, addressable: location, street: 'Test street', city: 'Test City', state: 'Test State', zip_code: '12345', country: 'Test Country')
      expect(address).to be_valid
    end

    it 'is not valid without required attributes' do
      address = build(:address, addressable: location, street: nil)
      expect(address).to_not be_valid
      expect(address.errors[:street]).to include("can't be blank")
    end

    it 'is not valid without an addressable' do
      address = build(:address, addressable: nil)
      expect(address).to_not be_valid
      expect(address.errors[:addressable]).to include("can't be blank")
    end
  end

  describe 'callbacks' do
    it 'sets the other addresses to not primary when a new primary address is set' do
      address1 = create(:address, street: 'Test Street 1', addressable: location, primary: true)
      address2 = create(:address, street: 'Test Street 2', addressable: location, primary: false)
      address3 = create(:address, street: 'Test Street 3', addressable: location, primary: false)

      address3.update(primary: true)
      expect(address1.reload.primary).to be(false)
      expect(address3.reload.primary).to be(true)
    end
  end
end
