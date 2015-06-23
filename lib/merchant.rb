require 'pry'
class Merchant
  attr_reader :merchant_repo, :id, :name, :created_at, :updated_at

  def initialize(row, merchant_repo)
    @merchant_repo = merchant_repo
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def items
    @merchant_repo.find_all_items_by_merchant_id(id)
  end

  def invoices
    @merchant_repo.find_all_invoices_by_merchant_id(id)
  end

  def revenue
    invoice_items = successful_invoices.map {|invoice| invoice.invoice_items}
    invoice_items.flatten.reduce(0) do |total, invoice_item|
      (invoice_item.quantity * invoice_item.unit_price) + total
    end
  end
  def merchant_transactions
    invoices.map {|invoice| invoice.transactions}
  end
  def successful_transactions
    merchant_transactions.flatten.find_all {|transaction| transaction.success? }
  end
  def successful_invoices
    successful_transactions.flatten.map {|transaction| transaction.invoice}
    # binding.pry
  end
end

