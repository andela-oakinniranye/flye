class Flight < ActiveRecord::Base
  belongs_to :origin, class_name: 'Airport'
  belongs_to :destination, class_name: 'Airport'
  has_many :bookings
  has_many :passengers, through: :bookings

  def self.search(destination: nil, origin: nil, departure_date: '')
      date = Time.zone.parse(departure_date)
      range = date + 1.month if date

    if date.nil?
      where(destination: destination, origin: origin).closest
    else
      where(destination: destination, origin: origin, departure_date: date..range)
    end
  end

  def self.closest
    where('departure_date >= ?', Date.today)
  end

  def self.featured
    closest.order(departure_date: 'asc').first
  end

end
