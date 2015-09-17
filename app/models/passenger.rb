class Passenger < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :reservations
  has_many :bookings, through: :reservations
  belongs_to :user
  has_many :flights, through: :bookings
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }
  validate :with_firstname_or_last_name

  def booking_uniq_id(booking)
    booking.reservations.where(passenger: self).select(:uniq_id).first
  end

  private
    def with_firstname_or_last_name
      if first_name.blank? && last_name.blank?
        errors.add(:first_name, "You must provide either a First Name or Last Name")
      end
    end

end
