function remove_fields(link){
  $(link).prevAll("input[type=hidden]").first().val("1");
  $(link).closest('li').hide();
  decrement_price()
}

function add_fields(link, association, content){
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, 'g');
  field = content.replace(regexp, new_id);
  $('.booking-item-passengers').append(field);
  increment_price();
}

function decrement_price(){
  data_span = $('#flight_price_span');
  passengers_count = data_span.data('total-passengers');
  passengers_count --;
  price = data_span.data('flight-price')
  data_span.data('total-passengers', passengers_count)
  calculate_price(passengers_count, price)
}

function increment_price(){
  data_span = $('#flight_price_span');
  passengers_count = data_span.data('total-passengers');
  passengers_count ++;
  price = data_span.data('flight-price')
  data_span.data('total-passengers', passengers_count)
  calculate_price(passengers_count, price)
}

function calculate_price(total_passengers, flight_price){
  total_price = flight_price * total_passengers
  price_s = total_price.formatMoney(2, '.', ',');
  $('#total_fare').html('$' + price_s);
}

$(document).ready(function() {
  span_to_update = $('#flight_price_span').data('action-span');
  if(span_to_update == 'bookings_edit' || span_to_update == 'bookings_new'){
    passengers_count = $(".each_passenger_field").size();
    $('#flight_price_span').data('total-passengers', passengers_count);
    calculate_price(passengers_count, $('#flight_price_span').data('flight-price'));
  }
  $('.airport_select').select2();
})
