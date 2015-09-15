class Booking < ActiveRecord::Base
  before_create :add_uniq_id
  before_save :calculate_cost

  belongs_to :flight
  has_many :reservations
  has_many :passengers, through: :reservations
  belongs_to :user
  accepts_nested_attributes_for :passengers, allow_destroy: true, reject_if: :all_blank
  enum status: [:unpaid, :paid]
  validate :that_it_has_passengers
  validates :flight, presence: true

  def add_uniq_id
    self.uniq_id = SecureRandom.hex
  end

  def paypal_url(return_path)
    values = {
        business: ENV['PAYPAL_BUSINESS'],
        cmd: "_xclick",
        return: "#{ENV['app_host']}#{return_path}",
        invoice: uniq_id,
        amount: self.flight.price,
        item_name: "Flight booking from #{self.flight.origin.location} to #{self.flight.destination.location}",
        item_number: id,
        quantity: self.passengers.count,
        notify_url: "#{ENV['paypal_notify_url']}/hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end

  def self.validate_url
    "#{ENV['paypal_host']}/cgi-bin/webscr?cmd=_notify-validate"
  end

  def calculate_cost
    cost = flight.price * passengers.size
    self.amount = cost
  end

  def that_it_has_passengers
    if self.passengers.blank?
      errors.add(:passengers, "You need to add at least one passenger")
    end
  end
end
