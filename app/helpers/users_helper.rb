module UsersHelper
  def flight_status_active_or_canceled(flight)
    content_tag :td, class: "text-center" do
      if flight.departure_date > DateTime.now
        content_tag( :i, nil, class: "fa fa-check") + " Active"
      elsif flight.departure_date < DateTime.now
        content_tag(:i, nil, class: "fa fa-ban") + " Departed"
      else
        "Unknown"
      end
    end
  end

  def link_to_cancel_flight_booking(booking)
    flight = booking.flight
    if flight.departure_date > DateTime.now
      link_to 'Cancel', booking, class: "btn btn-default btn-sm",
                                method: :delete,
                                data: { confirm: "You are about to cancel your flight booking from #{flight.origin.location} to #{flight.destination.location}.\nAre you sure?" }

    end
  end

  def checked_if_paid(booking)
    content_tag(:i, nil, class: 'fa fa-check-circle text-success') if booking.paid?
  end
end
