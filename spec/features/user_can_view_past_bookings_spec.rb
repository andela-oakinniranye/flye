require 'rails_helper'

RSpec.feature "UserCanViewPastBookings", type: :feature do

  scenario "Signed in user should be able to view past bookings" do
    all_flights = []
    booking_times = 3

    visit root_path
    click_link('Log in')
    click_link('Google')

    booking_times.times{
      flight = Flight.fetch_all.order('RANDOM()').first
      all_flights << flight

      visit flights_path

      choose(flight.name)

      page.find("#btn_#{flight.id}").click

      fill_in('booking[passengers_attributes][0][first_name]', with: Faker::Name.first_name)
      fill_in('booking[passengers_attributes][0][last_name]', with: Faker::Name.last_name)
      fill_in('booking[passengers_attributes][0][email]', with: Faker::Internet.email)

      click_link_or_button('Continue')

    }

    visit profile_path

    all_flights.each{ |flight|
      expect(page).to have_selector('td.booking-history-title', text: "#{flight.origin.location} to #{flight.destination.location}")
    }
    expect(page).to have_selector('td.booking-history-title', count: booking_times)
  end

  scenario "Annonymous users cannot view past flights: redirects to root_path" do
    visit profile_path

    expect(page.current_path).to eq root_path
  end
end
