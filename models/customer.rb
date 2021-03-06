require_relative('../db/sql_runner.rb')

class Customer

attr_accessor :name, :funds
attr_reader :id

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customers;"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { | customer | Customer.new(customer) }
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ( $1, $2 ) WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    values = []
    SqlRunner.run(sql, values)
  end

  def films_customer_has_seen()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return film_data.map { |film| Film.new(film)}
  end

  def customer_buys_ticket
    customer_films = self.films_customer_has_seen
    film_prices = customer_films.map { |films| films.price }
    combined_prices = film_prices.sum
    return @funds - combined_prices
  end

  def tickets_bought_by_customer()
    sql = "SELECT tickets.* FROM tickets LEFT JOIN customers ON customers.id = tickets.customer_id WHERE customer_id = $1;"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    tickets_map = tickets.map { | ticket | Ticket.new(ticket)}
    return tickets_map.length
  end





end
