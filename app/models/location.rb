class Location < ApplicationRecord
  include HasNormalizedId

  has_many :appointments, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  validates :name, :address, presence: true
end
