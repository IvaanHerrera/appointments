class Email < ApplicationRecord
  belongs_to :emailable, polymorphic: true
  validates :address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :primary, uniqueness: { scope: :emailable, message: "Only one email can be primary" }, if: :primary?

  before_save :unset_other_primaries, if: :primary?

  private

  def unset_other_primaries
    emailable.emails.where.not(id: id).update_all(primary: false)
  end
end
