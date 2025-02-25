class Email < ApplicationRecord
  belongs_to :emailable, polymorphic: true

  validates :address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :emailable, presence: true
  validates :primary, uniqueness: { scope: :emailable, message: "Only one email can be primary" }, if: :primary?

  before_validation :unset_other_primaries, if: :primary?

  private

  def unset_other_primaries
    return unless primary? && emailable.present?
    emailable.emails.where.not(id: id).where(primary: true).update_all(primary: false)
  end
end
