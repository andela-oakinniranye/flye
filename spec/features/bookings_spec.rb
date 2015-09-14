require 'rails_helper'

RSpec.feature "Bookings", type: :feature do
  scenario 'User can book flight' do
    flight = Flight.closest.first
    origin = flight.origin
    destination = flight.destination

    visit new_flight_booking_path(flight)

    fill_in('booking[passengers_attributes][0][first_name]', with: Faker::Name.first_name)
    fill_in('booking[passengers_attributes][0][last_name]', with: Faker::Name.last_name)
    fill_in('booking[passengers_attributes][0][email]', with: Faker::Internet.email)

    click_link_or_button('Continue')

    expect(page).to have_selector('h5.text-center', text: "Flight from #{origin.location} to #{destination.location} on #{ flight.departure_date.strftime("%A, %b %-d %Y")}")
    expect(page).to have_selector('a.btn-primary', text: 'Checkout via Paypal' )
  end
end
