class BookingMailer < ApplicationMailer
  default from: 'booking@flye.com'

  def send_booking_mail(booking)
    @booking = booking
    booking.passengers.each do |passenger|
      BookingMailer.send_passenger_ticket_mail(passenger, booking).deliver_now
    end
    thank_you_for_booking_mail(booking.user.decorate) if booking.user
  end


  def send_passenger_ticket_mail(passenger, booking)
    @passenger = passenger
    @flight = booking.flight
    @uniq_booking_id = passenger.booking_uniq_id(booking).uniq_id
    email_with_name = %("#{@passenger.first_name}" <#{@passenger.email}>)
    mail(to: email_with_name, subject: "Your Flight Ticket Details")
  end

private
  def thank_you_for_booking_mail(user)
    @user = user
    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "Thanks for booking")
  end

end
