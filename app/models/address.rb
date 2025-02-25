class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, :city, :state, :zip_code, :country, presence: true
  validates :addressable, presence: true

  validates :primary, uniqueness: { scope: :addressable, message: "Only one address can be primary" }, if: :primary?

  before_validation :unset_other_primaries, if: :primary?

  private

  def unset_other_primaries
    return unless primary? && addressable.present?

    addressable.addresses.where.not(id: id).where(primary: true).update_all(primary: false)
  end
end
