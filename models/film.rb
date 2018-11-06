require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
    values = [@title, @price]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films;"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { | film | Film.new(film) }
    return result
  end

  def update()
    sql = "UPDATE films SET (title, price) = ( $1, $2 ) WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers_that_have_seen_film()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return customer_data.map { |customer| Customer.new(customer)}
  end

  def customers_watching_film
    number_of_customers = customers_that_have_seen_film
    return number_of_customers.length
  end


end
