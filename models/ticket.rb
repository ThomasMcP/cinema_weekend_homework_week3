require_relative('../db/sql_runner.rb')

class Customer


attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'] if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
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



end
