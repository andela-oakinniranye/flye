class Flight < ActiveRecord::Base
  belongs_to :origin, class_name: 'Airport'
  belongs_to :destination, class_name: 'Airport'
  has_many :bookings
  has_many :passengers, through: :bookings

  validates :origin, presence: true
  validates :destination, presence: true
  validate :origin_and_destination_are_not_the_same

  def origin_and_destination_are_not_the_same
    if origin == destination
      errors.add(:origin, "Origin and Departure point cannot be the same")
    end
  end

  def self.search(destination: nil, origin: nil, departure_date: '')
    date = Time.zone.parse(departure_date)
    range = date + 1.month if date

    if date.nil?
      where(destination: destination, origin: origin).closest.fetch_all
    else
      where(destination: destination, origin: origin, departure_date: date..range).fetch_all
    end
  end

  def self.closest
    where('departure_date >= ?', DateTime.now).order(departure_date: 'asc')
  end

  def self.featured
    closest.order(departure_date: 'asc').first
  end

  def self.fetch_all
    closest.includes(:origin).includes(:destination)
  end
end
