require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

customer1 = Customer.new({'name' => 'Thomas', 'funds' => 100})
customer1.save()

customer2 = Customer.new({'name' => 'Jeffery', 'funds' => 100})
customer2.save()

film1 = Film.new({'title' => 'The Dark Knight', 'price' => 10})
film1.save()

film2 = Film.new({'title' => 'Batman Begins', 'price' => 10})
film2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id })
ticket2.save()

ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id })
ticket3.save()

customer1.films_customer_has_seen()
film1.customers_that_have_seen_film()
customer1.customer_buys_ticket()




# film1 = Film.ne
# customer2.funds = 30
# customer2.update()



# Customer.all()
# Customer.delete_all()





binding.pry
nil
