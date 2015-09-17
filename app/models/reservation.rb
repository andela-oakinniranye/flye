class Reservation < ActiveRecord::Base
  include AddUniqId

  before_create :add_uniq_id

  belongs_to :booking
  belongs_to :passenger
  belongs_to :user
end
