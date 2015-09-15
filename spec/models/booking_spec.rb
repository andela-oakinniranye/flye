require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:passenger){ Passenger.new(first_name: ['Kay', 'Stephen', 'Alex'].sample, email: Faker::Internet.email) }
  let(:flight){ Flight.last}
  let(:booking){
     booking = Booking.new
     booking
  }

  let(:with_passengers){
    3.times{
      booking.passengers << passenger
    }
    booking
  }

  let(:with_flight){
    booking.flight = flight
    booking
  }

  let(:valid_booking){
     with_flight
     with_passengers
   }

  it "is invalid without a passenger" do
    with_flight.save
    expect(with_flight).not_to be_valid
  end

  it "is invalid without a flight" do
    with_passengers.save

    expect(with_passengers).not_to be_valid
  end

  it "is valid with a passenger and flight" do
    valid_booking.save

    expect(booking).to be_valid
  end

  it 'has a uniq_id when saved, which becomes an invoice number for payment' do
    valid_booking.save

    expect(valid_booking.uniq_id).not_to be nil
    expect(valid_booking.uniq_id).not_to be_a Integer

  end
end
