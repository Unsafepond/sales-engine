require_relative "sales_engine"
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(hashes)
    @all = hashes.map { |hash| Invoice.new(hash.to_hash, self)}
  end

  def random
    @all.shuffle
  end
  def find_by_id(id)
    @all.select { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    @all.select { |invoice| invoice.customer_id == customer_id}
  end
end