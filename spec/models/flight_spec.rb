require 'rails_helper'

RSpec.describe Flight, type: :model do
  let(:flight){ Flight.new }

  it 'is invalid without an origin and destination' do
    flight.save
    expect(flight).not_to be_valid
  end

  it 'can correctly search based on origin and destination passed to it' do
    sample_flight = Flight.closest.last
    flights = Flight.search(origin: sample_flight.origin, destination: sample_flight.destination, departure_date: sample_flight.departure_date.to_s)
    expect(flights.last).to eq sample_flight
    flights.each do |flight|
      expect(flight.departure_date).to be >= sample_flight.departure_date
      expect(flight.origin).to eq sample_flight.origin
      expect(flight.destination).to eq sample_flight.destination
    end
  end

  it 'does not have the same origin and destination point' do
    flight.origin = Airport.first
    flight.destination = Airport.first
    flight.save

    expect(flight).not_to be_valid
  end
end
