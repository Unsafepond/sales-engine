require 'pry'
require_relative 'customer'
require_relative 'sales_engine'

class CustomerRepository
  attr_reader :customer,
              :all

  def initialize(hashes, sales_engine)
    @customers = hashes.map { |hash| Customer.new(hash.to_hash, self)}
    @sales_engine = sales_engine
  end
  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
  def all
    @customers
  end
  def find_by_id(id)
    all.find { |customer| customer.id == id }
  end

  def find_all_by_id(id)
    all.select { |customer| customer.id == id }
  end

  def random
    all.shuffle.first
  end

  def find_by_first_name(name)
    all.find { |customer| customer.first_name == name }
  end

  def find_all_by_first_name(name)
    all.select { |customer| customer.first_name == name }
  end

  def find_by_last_name(name)
    all.find { |customer| customer.last_name == name }
  end

  def find_all_by_last_name(name)
    all.select { |customer| customer.last_name == name }
  end

  def find_by_created_at(create_date)
    all.find { |customer| customer.created_at == create_date }
  end

  def find_all_by_created_at(created_at)
    all.select { |customer| customer.created_at == created_at }
  end

  def find_by_updated_at(update_date)
    all.find { |customer| customer.updated_at == update_date }
  end

  def find_all_by_updated_at(updated_at)
    all.select { |customer| customer.updated_at == updated_at }
  end

  def find_all_invoices_by_customer_id(id)
    @sales_engine.find_all_invoices_by_customer_id(id)
  end

end