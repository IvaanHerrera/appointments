require 'rails_helper'

RSpec.describe Email, type: :model do
  let(:client) { create(:client) }

  describe 'validations' do
    it 'is valid with a properly formatted email address' do
      email = build(:email, address: 'test@example.com', emailable: client)
      expect(email).to be_valid
    end

    it 'is not valid with an invalid email address' do
      email = build(:email, address: 'invalid-email', emailable: client)
      expect(email).not_to be_valid
    end

    it 'is not valid without an email address' do
      email = build(:email, address: nil, emailable: client)
      expect(email).not_to be_valid
    end

    it 'is not valid without an emailable' do
      email = build(:email, emailable: nil)
      expect(email).not_to be_valid
    end
  end

  describe 'callbacks' do
    it 'sets the other emails to not primary when a new primary email is set' do
      email1 = create(:email, emailable: client, primary: true)
      email2 = create(:email, emailable: client, primary: false)
      email3 = create(:email, emailable: client, primary: false)

      email3.update(primary: true)

      expect(email1.reload.primary).to be(false)
      expect(email3.reload.primary).to be(true)
    end
  end
end
