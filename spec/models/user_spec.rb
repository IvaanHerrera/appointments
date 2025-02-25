require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe 'callbacks' do
    it 'sets a default name from the email' do
      user = build(:user, email: 'test@example.com', name: nil)
      user.save
      expect(user.name).to eq('Test')
    end

    it 'does not overwrite the name if it is provided' do
      user = build(:user, email: 'test@example.com', name: 'Custom Name')
      user.save
      expect(user.name).to eq('Custom Name')
    end
  end
end
