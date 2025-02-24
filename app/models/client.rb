class Client < ApplicationRecord
  include HasNormalizedId

  has_many :appointments, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :emails, as: :emailable, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :emails, allow_destroy: true

  validates :first_name, :last_name, presence: true

  def full_name
    [first_name, last_name].join(' ').strip
  end
end
