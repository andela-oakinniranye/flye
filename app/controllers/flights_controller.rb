class FlightsController < ApplicationController
  before_action :set_flight, only: [:show]

  def index
    @airports = Airport.all
    if search_params
      return if empty_search_params?
      return if origin_is_same_as_destination?
      search_helper(search_params)
    else
      @flights = Flight.fetch_all.paginate(page: params[:page])
    end
    respond_to :js, :html
  end

  private
    def search_helper(search_params)
      @flights = Flight.search(search_params.except(:no_of_passengers).symbolize_keys).paginate(page: params[:page])
      flights_origin_and_destination = Airport.get_names(search_params[:origin],search_params[:destination])
      @origin = flights_origin_and_destination.first
      @destination = flights_origin_and_destination.last
      @required_passengers = search_params[:no_of_passengers]
      flash[:message] = "There are no flights from #{@origin.location} to #{@destination.location}" if @flights.blank?
    end

    def set_flight
      @flight = Flight.find(params[:id])
    end

    def search_params
      params.require(:flight).permit(:origin, :destination, :departure_date, :no_of_passengers) if params[:flight]
    end

    def empty_search_params?
      if search_params[:origin].blank? || search_params[:destination].blank?
        flash[:danger] = "Sorry, you should enter an origin and departure point"
        true
      end
    end

    def origin_is_same_as_destination?
      if search_params[:origin] == search_params[:destination]
        flash[:danger] = "Flight Destination and Origin cannot be the same!"
        true
      end
    end
end
