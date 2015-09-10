class Reservation < ActiveRecord::Base
  belongs_to :booking
  belongs_to :passenger
  belongs_to :user
end
