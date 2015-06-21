require_relative 'sales_engine'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(hashes, sales_engine)
    @all = hashes.map { |hash| Invoice.new(hash.to_hash, self)}
    @sales_engine = sales_engine
  end

  def random
    @all.shuffle.first
  end
  def find_by_id(id)
    @all.find { |invoice| invoice.id == id }
  end

  def find_by_customer_id(customer_id)
    @all.find { |invoice| invoice.customer_id == customer_id}
  end

  def find_by_merchant_id(merchant_id)
    @all.find { |invoice| invoice.merchant_id == merchant_id}
  end

  def find_merchant_by_invoice_id(invoice_id)
    invoice = find_by_id(invoice_id)
    @sales_engine.merchant_repository.find_by_id(invoice.merchant_id)
  end

  def find_by_status(status)
    @all.find { |invoice| invoice.status == status}
  end

  def find_by_created_at(created_at)
    @all.find { |invoice| invoice.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    @all.find { |invoice| invoice.updated_at == updated_at}
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

  def find_invoice_merchant_with_merchant_id(merchant_id)
    @sales_engine.find_invoice_merchant_with_merchant_id(merchant_id)
  end

  def find_invoice_customer_with_customer_id(customer_id)
    @sales_engine.find_invoice_customer_with_customer_id(customer_id)
  end

  def find_invoices_invoice_items(id)
    @sales_engine.find_invoices_invoice_items(id)
  end

  def find_invoices_transactions(id)
    @sales_engine.find_invoices_transactions(id)
  end

  def find_items_in_invoice(id)
    @sales_engine.find_items_in_invoice(id)
  end
end