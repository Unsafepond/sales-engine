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
    @all.select { |invoice| invoice.customer_id == customer_id}.first
  end

  def find_by_merchant_id(merchant_id)
    @all.select { |invoice| invoice.merchant_id == merchant_id}.first
  end

  def find_by_status(status)
    @all.select { |invoice| invoice.status == status}.first
  end

  def find_by_created_at(created_at)
    @all.select { |invoice| invoice.created_at == created_at}.first
  end

  def find_by_updated_at(updated_at)
    @all.select { |invoice| invoice.updated_at == updated_at}.first
  end

  def find_all_by_id(id)
    @all.select { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @all.select { |invoice| invoice.customer_id == customer_id }

  end

  def find_all_by_merchant_id(merchant_id)
    @all.select { |invoice| invoice.merchant_id == merchant_id }

  end

  def find_all_by_status(status)
    @all.select { |invoice| invoice.status == status }

  end

  def find_all_by_created_at(created_at)
    @all.select { |invoice| invoice.created_at == created_at }

  end
  def find_all_by_updated_at(updated_at)
    @all.select { |invoice| invoice.updated_at == updated_at }

  end


end