class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :can_still_edit?, only: [:edit, :update, :destroy]
  protect_from_forgery except: [:hook]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    @payment_url = @booking.paypal_url(booking_path(@booking))
    @origin = @booking.flight.origin
    @destination = @booking.flight.destination
  end

  # GET /bookings/new
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.new
    build_params = params[:no_of_passengers] || 1
    build_params.to_i.times{ @booking.passengers.build }
  end

  # GET /bookings/1/edit
  def edit
  end

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      response = validate_IPN_notification(request.raw_post)

      case response
      when "VERIFIED"
        @booking = Booking.find_by_uniq_id(params[:invoice])
        @booking.paid!
        @booking.update(txn_id: params[:txn_id])
      when "INVALID"

      else
        # trigger error mailer for investigation
      end
    end
    render nothing: true
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user if current_user
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
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

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit( :flight_id ,passengers_attributes: [:id, :_destroy, :first_name, :last_name, :email])
      # params[:booking]
    end

    def validate_IPN_notification(raw)
      uri = URI.parse(Booking.notify_url)
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

    def can_still_edit?
      if @booking.paid?
        flash[:notice] = "Sorry, you can only edit a booking before payment"
        redirect_to @booking
      end
    end

    def can_still_cancel?
      if @booking.flight.departure_date > DateTime.now
        flash[:notice] = "You canonly cancel your booking before a flight!"
        redirect_to request.referer
      end
    end
end
