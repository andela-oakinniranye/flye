class Airport < ActiveRecord::Base
  has_many :origins, class_name: 'Flight', foreign_key: 'origin_id'
  has_many :destinations, class_name: 'Flight', foreign_key: 'destination_id'
  has_many :bookings, through: :origins
end
