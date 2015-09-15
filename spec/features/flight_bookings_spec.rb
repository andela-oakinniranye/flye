require 'rails_helper'

RSpec.feature "FlightBookings", type: :feature do
  scenario "User should be able to search for a flight" do
    flight = Flight.closest.first
    origin_airport = flight.origin
    destination_airport = flight.destination

    visit root_path

    expect(page).to have_selector('h5', text: 'Search for Cheap Flights')

    click_link('Log in')
    expect(page).to have_selector('a.btn-googleplus')

    click_link('Google')
    wait_for_ajax


    select(origin_airport.name, from: 'flight[origin]')
    select(destination_airport.name, from: 'flight[destination]')

    click_button 'Search for Flights'
    wait_for_ajax


    expect(page).to have_content "Showing"
    choose(flight.name)

    click_button("Book Flight")

    expect(page).to have_field('booking[passengers_attributes][0][first_name]')
    expect(page).to have_field('booking[passengers_attributes][0][last_name]')
    expect(page).to have_field('booking[passengers_attributes][0][email]')
  end
end
