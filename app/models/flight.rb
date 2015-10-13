class Flight < ActiveRecord::Base
  belongs_to :origin, class_name: 'Airport'
  belongs_to :destination, class_name: 'Airport'

  has_many :bookings
  has_many :passengers, through: :bookings

  validates :origin, presence: true
  validates :destination, presence: true
  validates :departure_date, presence: true
  validates :arrival_date, presence: true

  validate :origin_and_destination_are_not_the_same
  validate :departure_date_cannot_be_in_the_past
  validate :arrival_date_cannot_be_less_than_departure_date

  def self.search(destination: nil, origin: nil, departure_date: '')
    date = Time.zone.parse(departure_date)
    range = date + 1.month if date

    if date.nil?
      where(destination: destination, origin: origin).fetch_all
    else
      where(destination: destination, origin: origin, departure_date: date..range).fetch_all
    end
  end

  def self.closest
    where('departure_date >= ?', DateTime.now).order(departure_date: :asc)
  end

  def self.featured
    closest.first
  end

  def self.fetch_all
    closest.includes(:origin).includes(:destination)
  end

  private
    def origin_and_destination_are_not_the_same
      if origin == destination
        errors.add(:origin, "Origin and Departure point cannot be the same")
      end
    end

    def departure_date_cannot_be_in_the_past
      if DateTime.now.to_i > departure_date.to_i
        errors.add(:departure_date, "Departure date cannot be in the past")
      end
    end

    def arrival_date_cannot_be_less_than_departure_date
      if arrival_date.to_i < departure_date.to_i
        errors.add(:arrival_date, "Arrival date must be in the future after the departure date")
      end
    end
end
