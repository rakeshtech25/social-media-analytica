# README

* Ruby Version 2.7.0

* Rails Version 6.0.3

#### Instructions

* Clone repo
* Install the bundle as `bundle install`
* Start the rails server using `rails s`
* Visit `localhost:3000` on browser or hit `curl localhost:3000` on terminal
* Run the test cases `bundle exec rspec `

##### Description

* Application to let client know what is happening on the social networks
* Social media analytical result from Facebook, Twitter, Instagram
* Error handeling for various HTTP status code 
* Expected output from the takehome.io endpoint is a valid JSON for success case
* JSON response of the output from the three social networks in the format:
	`{ twitter: [tweets], facebook: [statuses], instagram: [photos] }`
* Test cases management useing Rspec library