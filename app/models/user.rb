class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include HasNormalizedId

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :appointments, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: true

  before_create :set_default_name

  private

  def set_default_name
    return if name.present?
    self.name = email.split('@').first.capitalize
  end
end
