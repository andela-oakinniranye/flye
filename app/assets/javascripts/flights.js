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
});
