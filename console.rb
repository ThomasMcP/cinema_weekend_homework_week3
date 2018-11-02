require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

customer1 = Customer.new({'name' => 'Thomas', 'funds' => 100})
customer1.save()
customer2 = Customer.new({'name' => 'Jeffery', 'funds' => 100})
customer2.save()
# film1 = Film.ne
customer2.funds = 30
customer2.update()


# Customer.all()
# Customer.delete_all()





binding.pry
nil
