Flight Booking App
Pre-work requirements:
To complete this checkpoint you must have completed Modules 1, 2, 3, 4, 5, 6, 7, 8, and 9.

Project Description:
In this project, you'll get a chance to tackle some advanced forms. This is the kind of thing you'll have to work with when handling user orders for anything more complicated than an e-book.

This project will require you to seed your database, so use your db/seeds.rb file to write the code necessary to populate Airports and Flights. One trick for apps like this (don't do it for production!) is to make your seeds file ::delete_all items from each table in your database and then completely repopulate them. That way, when you create a new model or change how you want your sample data set up, you can just update the seeds.rb file and rerun $ rake db:seed.

Learning Objectives
By the end of this checkpoint, you should understand:

Rails MVC
Understand how to build nested forms.


Project Requirements (in the form of User stories!):
Base:
Given that I am an anonymous user of the system
When I visit the site
And select an item from each of 4 dropdown (From, To, No of passengers, Flight date)
Then I should be able to search for flight that meets the criteria I selected.

Given that I have selected an item from each dropdown
When I click on search
Then all search result should display on the same  page

Given that I have selected which flight I want to book from the search result returned, by selecting a radio button
When I click on select flight button
Then I should be taken to a flight booking page

Given that I am in the flight booking page that shows the trip details (Flight No, From - To destination,  Flight date) as well as forms to  fill the details of each passenger that I am booking for.
When I fill all the details of the passenger
And click on book flight button
Then I should be taken to a booking confirmation page that shows my confirmation number and details of the passengers I am booking for.

Given that I book a flight.
When the booking is successful
Then I should receive a thank you email containing all details displayed in the booking confirmation page.

Extra:
Given that I am in the flight booking  page
When I click  on book flight button
Then I should be taken to a billing page where I will pay for the booking (you can integrate with paypal via Paypal Gem.

Given that I am an anonymous user
When I try to book a flight
Then I should be redirected to a login page to log into the system before proceeding to booking.

Given that I am a registered user
When I click on Past Booking
Then I should be taken to a page where I will see  all bookings I have made in the past.

Important Points:
The project should be live on Heroku.
You should have at least 4 models (Airport, Flight, Passenger, Booking)
You should use nested forms when creating the form in flight booking page.
You should make use of letter_opener gem.
Use the Send Grid addon on heroku for sending emails
