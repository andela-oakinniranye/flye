class BookingsController < ApplicationController
  # before_action :logged_in?, except:
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :check_that_user_owns_this_booking, only: [:destroy]
  before_action :can_still_cancel?, only: [:destroy]
  protect_from_forgery except: [:hook]

  def index
    @booking = current_user.bookings.includes(:flight)
  end

  def show
    @payment_url = @booking.paypal_url(booking_path(@booking))
    @origin = @booking.flight.origin
    @destination = @booking.flight.destination
  end

  def new
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.new
    build_params = params[:no_of_passengers].blank? ? 1 : params[:no_of_passengers].to_i
    build_params.times{ @booking.passengers.build }
  end

  def edit
  end

  def hook
    params.permit! # Permit all Paypal
    status = params[:payment_status]
    if status == "Completed"
       response = validate_IPN_notification(request.raw_post)
       examine_booking(response)
    end
    render nothing: true
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user if current_user
    flight = @booking.flight
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        flash[:danger] = @booking.errors.full_messages
        format.html { redirect_to new_flight_booking_path(flight) }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    origin = @booking.flight.origin
    destination = @booking.flight.destination
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to profile_url, notice: "Your flight booking from #{origin.location} to #{destination.location} was successfully canceled." }
      format.json { head :no_content }
    end
  end

  def book
    unless params[:flight_id]
      flash[:danger] = "Sorry, you have to select a Flight"
      redirect_to :back and return
    end
    redirect_to new_flight_booking_path(params[:flight_id], no_of_passengers: params[:no_of_passengers])
  end


  private

    def examine_booking(response)
      case response
      when "VERIFIED"
        @booking = Booking.find_by_uniq_id(params[:invoice])
        booking_accepted(@booking) if @booking
        #create a logger for invalid bookings
      when "INVALID"

      else
        # trigger error mailer for investigation
      end
    end

    def booking_accepted(booking)
      booking.paid!
      booking.update(txn_id: params[:txn_id])
      BookingMailer.send_booking_mail(booking).deliver_now
    end

    def set_booking
      @booking = Booking.find(params[:id]) unless current_user
      @booking = current_user.bookings.find(params[:id]) if current_user
    end

    def booking_params
      params.require(:booking).permit( :flight_id ,passengers_attributes: [:id, :_destroy, :first_name, :last_name, :email])
    end

    def validate_IPN_notification(raw)
      uri = URI.parse(Booking.validate_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = 60
      http.read_timeout = 60
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
      response = http.post(uri.request_uri, raw,
                           'Content-Length' => "#{raw.size}",
                           'User-Agent' => "Highness"
                         ).body
    end

    def check_that_user_owns_this_booking
      unless @booking.user == current_user
        flash[:notice] = "You can only cancel a booking you created"
        redirect_to (request.referer || profile_path)
      end
    end

    def can_still_cancel?
      if @booking.flight.departure_date < DateTime.now
        flash[:notice] = "You can only cancel your booking before a flight!"
        redirect_to (request.referer || root_path)
      end
    end
end
