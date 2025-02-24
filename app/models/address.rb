class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, :city, :state, :zip_code, :country, presence: true
  validates :primary, uniqueness: { scope: :addressable, message: "Only one address can be primary" }, if: :primary?

  before_save :unset_other_primaries, if: :primary?

  private

  def unset_other_primaries
    addressable.addresses.where.not(id: id).update_all(primary: false)
  end
end
