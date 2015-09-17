require 'rails_helper'

RSpec.describe Flight, type: :model do
  let(:flight){ Flight.new }
  let(:with_origin_and_destination){ flight.origin = Airport.last; flight.destination = Airport.first; flight}
  let(:with_departure_and_arrival_date){ flight.departure_date = DateTime.now + 1.hour; flight.arrival_date = flight.departure_date + 3.hours; flight}
  let(:valid_flight){
    with_origin_and_destination
    with_departure_and_arrival_date
  }

  it 'is invalid without an origin and destination' do
    with_departure_and_arrival_date.save

    expect(with_departure_and_arrival_date).not_to be_valid
  end

  it 'is invalid without a departure date and arrival date' do
    with_origin_and_destination.save

    expect(with_origin_and_destination).not_to be_valid
  end

  it 'is valid with origin, destination, departure date and arrival date' do
    valid_flight.save

    expect(valid_flight).to be_valid
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
    with_departure_and_arrival_date.origin = Airport.first
    with_departure_and_arrival_date.destination = Airport.first
    with_departure_and_arrival_date.save

    expect(with_departure_and_arrival_date).not_to be_valid
  end

  it 'cannot depart in the past' do
    with_origin_and_destination.departure_date = DateTime.now - 1.hour
    with_origin_and_destination.arrival_date = with_origin_and_destination.departure_date + 2.hours
    with_origin_and_destination.save

    expect(with_origin_and_destination).not_to be_valid
  end

  it 'cannot arrive before the departure date' do
    with_origin_and_destination.departure_date = DateTime.now + 1.hour
    with_origin_and_destination.arrival_date = DateTime.now
    with_origin_and_destination.save

    expect(with_origin_and_destination).not_to be_valid
  end

end
