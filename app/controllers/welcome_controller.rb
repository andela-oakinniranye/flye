class WelcomeController < ApplicationController
  def index
    @airports = Airport.all
    @featured_flight = Flight.featured
  end
end
