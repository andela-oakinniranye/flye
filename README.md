# Flye

Ever dreamt of traveling to your dreamland whenever you want? Or looking for a cheap flight to a cool relaxation spot? Or just looking for the best Flight Search experience?

[Flye](https://flye.herokuapp.com) enables you to do this and so much more! Requirements This project requires that I implement a flight booking application which requires minimal efforts by the user, in order to search for flights given an origin and destination. More information about the project can be found [here](/requirements.md). [You can always Flye by visiting this link](https://flye.herokuapp.com)

To make payment with Paypal, use: username: tester@flye.com   
password: flyetester  

### Approach

In this sort of application, the most important considerations will be on the database associations, in order to remove redundant tables and queries amongst other things.

It also requires some thoughts on implementing the search, payment etc.

<op>I created two database tables: airports and flights, on which I tried different associations.

In order not to make a redundant [origin | destination] table, there is just one airports table from which the Flight model inherits its origin/destination from. Some of the challenges faced and lessons learnt in this phase includes understanding some complex associations, where a Model association has_many :origin and has_many :destinations, referring to itself: refer to Airport and Flight models (app/models)

Upon successfully implementing this associations, I took a forward approach to developing the other sides of the application, by viewing the extra requirements, to find out areas of improvements or pitfalls that may be encountered if I wanted to implement the extras.

Such includes the User model, which requires a login to make the booking in the extra, however I realized this will invalidate all the other requirements for booking, this made me to create a two-way system, whereby logged in users can book as well as users not logged in. However, users not logged in will not be able to view their past bookings or to cancel a booking.

Another important thing I learnt is the Paypal addition for payments on the platform. Even though, Paypal is very straight-forward to add to the platform, there are other checks that would be required since it involves payments, which could either drive people away from or in to the platform.

After a payment has been completed, Paypal has an Instant Payment Notification which works thus:

1.  Paypal posts the payments information to a url you have defined
2.  You receive this parameters/raw data and send it back to them(appending certain string to the paypal url to validate)
3.  Paypal sends back the data again, with a response.body of 'VERIFIED', 'INVALID' etc and they advise that you only process when VERIFIED

This is interesting, however not without it's own challenges

A lot of view functions were moved to the helper modules to reduce the amount of logic I would do in the views, also some validations were implemented first in javascript to reduce the amount of redundant operations performed by the server

The migration files also follows my thoughts process as regarding the models and associations needed.

Even though not required, I tried to also optimize my code for N+1 queries, thanks to [jeff](http://github.com/jwan622) who exposed me to the bullet gem which alerts me of these kind of queries

#### Future Plans

One of the things anyone would quickly notice is that the application has some extra database columns and data, which I hope to use to add extra perfomance to the application.

Scenario: User should be able to add passengers he has added before with minimal efforts such that when on the bookings page, I could find a box that either allows me to search for or select passengers I have booked for before.

Scenario: Booking should be editable after it has been created such that a user can edit the names/emails of his passengers, (and add more passengers if the flight is not yet paid for. This will require some careful thoughts though, as a fraudulent user can work around this if he understands my logic and thoughts process in this regard).

</op>
