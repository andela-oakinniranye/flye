class Passenger < ActiveRecord::Base
  has_many :reservations
  has_many :bookings, through: :reservations
  belongs_to :user
  has_many :flights, through: :bookings

end
