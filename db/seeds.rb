
Flight.destroy_all
Airport.destroy_all

airports_array = [
  {name: 'Nnamdi Azikwe International Airport', location: 'Abuja', symbol: 'ABV'},
  {name: 'Akanu Ibiam International Airport', location: 'Enugu', symbol: 'ENU'},
  {name: 'Mallam Aminu Kano International Airport', location: 'Kano', symbol: 'KAN'},
  {name: 'Murtala Muhammed International Airport', location: 'Lagos', symbol: 'LOS'},
  {name: 'Port Harcourt International Airport', location: 'Rivers', symbol: 'PHC'},
  {name: 'Sir Abubakar Tafawa Balewa Airport', location: 'Bauchi', symbol: 'ATB'},
  {name: 'Margaret Ekpo International Airport', location: 'Cross River', symbol: 'CBQ'},
  {name: 'Yakubu Gowon Airport', location: 'Plateau', symbol: 'JOS'},
  {name: 'Kaduna Airport', location: 'Kaduna', symbol: 'KAD'},
  {name: 'Maiduguri International Airport', location: 'Borno', symbol: 'MIU'},
  {name: 'Sadiq Abubakar III International Airport', location: 'Sokoto', symbol: 'SKO'},
  {name: 'Yola Airport', location: 'Adamawa', symbol: 'YOL'}
]

airlines_array = ['AeroContractors', 'Air Peace', 'Allied Air', 'Arik Air', 'Associated Aviation', 'Azman Air', 'Chanchangi Airlines', 'Dana Air', 'Discovery Air', 'Dornier Aviation Nigeria', 'First Nation Airways', 'IRS Airlines', 'Kabo Air', 'Max Air', 'Med-View Airline', 'Overland Airways', 'Overland Airways', 'TAT Nigeria']

  airports_array.each{ |airport|
    Airport.create(airport)
  }

100.times{
  forward_rand = Random.rand(0..30)
  departure_date = Faker::Time.forward(10, :morning)
  flight = Flight.new
  flight.name = airlines_array.sample
  flight.origin = Airport.order('RANDOM()').first
  flight.destination = Airport.order('RANDOM()').where.not(id: flight.origin.id).first
  flight.departure_date = departure_date
  flight.arrival_date = departure_date + forward_rand.hour
  flight.price = Faker::Commerce.price
  flight.save!
}
