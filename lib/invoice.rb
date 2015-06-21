require_relative 'invoice_repository'

class Invoice
  attr_reader :invoice_repo, :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(row, invoice_repo)
    @invoice_repo = invoice_repo
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def merchant
    invoice_repo.find_invoice_merchant_with_merchant_id(merchant_id)
  end

  def customer
    invoice_repo.find_invoice_customer_with_customer_id(customer_id)
  end

  def invoice_items
    invoice_repo.find_invoices_invoice_items(id)
  end

  def transactions
    invoice_repo.find_invoices_transactions(id)
  end

  def items
    invoice_repo.find_items_in_invoice(id)
  end
end
