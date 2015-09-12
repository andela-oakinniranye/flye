class BookingMailer < ApplicationMailer
  default from: 'booking@flye.com'

  def booking_mail(booking)
    @booking = booking
    booking.passengers.each do |passenger|
      BookingMailer.passenger_ticket_mail(passenger, booking.flight).deliver
    end
    thank_you_for_booking_mail(booking.user.decorate) if booking.user
  end


  def passenger_ticket_mail(passenger, flight)
    @passenger = passenger
    @flight = flight
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
