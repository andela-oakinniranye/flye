# require_relative '../../db/seeds.rb'



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed
  # Flight.destroy_all
  # Airport.destroy_all


  jfk = Airport.create(name: 'John F Kennedy Airport', location: 'New York', symbol: 'JFK')
  lhr = Airport.create(name: 'London Heathrow Airport', location: 'London', symbol: 'LHR')


  10.times{
      airport = Airport.new
      airport.name = Faker::Company.name
      airport.location = Faker::Address.city
      airport.symbol = airport.name[0,3].upcase
      airport.save!
  }

  flight = Flight.create(name: 'Custom', origin: jfk, destination: lhr, departure_date: Date.today, arrival_date: Date.tomorrow, price: 8996)

  99.times{
    forward_rand = Random.rand(0..30)
    departure_date = Faker::Time.forward(10, :morning)
    flight = Flight.new
    flight.name = Faker::Company.name.match(/\w+/)
    flight.origin = Airport.order('RANDOM()').first
    flight.destination = Airport.order('RANDOM()').where.not(id: flight.origin.id).first
    flight.departure_date = departure_date
    flight.arrival_date = departure_date + forward_rand.hour
    flight.price = Faker::Commerce.price
    flight.save!
  }
end
