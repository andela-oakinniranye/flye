// $(document).ready(function() {
//   $('.datepicker').datetimepicker({
//         format: "DD MMMM YYYY"
//     });
// });


// Reservation Form
    //jQueryUI - Datepicker
$(function(){
  if ($().datepicker) {
      $('#flight_departure_date').datepicker({
        // format: 'dd/mm/yyyy',
        startDate: '+1d'
      });
  }

  $('#flight_search_btn').click(function(e){
    var origin = $('#flight_origin').val();
    var destination = $('#flight_destination').val();
    var message;
    var check_same_location = same_location(origin, destination);
    var check_no_origin_or_destination = no_origin_or_destination(origin, destination);
    if(check_same_location || check_no_origin_or_destination){
      e.preventDefault();
      // console.log("I got here");
    }
  });

});


function same_location(origin, destination){
  if(origin == destination){
    toastr.warning("Flight Destination and Origin cannot be the same!");
    return true;
  }else{
    return false;
  }
}

function no_origin_or_destination(origin, destination){
  if(origin == '' || destination == ''){
    toastr.warning("Sorry, you should enter an origin and departure point")
    return true;
  }else{
    return false;
  }
}
