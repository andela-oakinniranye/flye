module FlightsHelper
  def search_result_info(origin, destination, total)
    content_tag :h4, "Showing #{total.humanize.capitalize} Search #{'Result'.pluralize(total)} For Flights From #{origin.location} to #{destination.location}", class: "booking-title text-center"
  end
end
