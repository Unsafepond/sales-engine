require_relative 'invoice_item_repository'
require 'bigdecimal'
require 'date'

class InvoiceItem
  attr_reader :invoice_item_repo, :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(row, invoice_item_repo)
    @invoice_item_repo = invoice_item_repo
    @id = row[:id].to_i
    @item_id = row[:item_id].to_i
    @invoice_id = row[:invoice_id].to_i
    @quantity = row[:quantity].to_i
    @unit_price = BigDecimal.new(row[:unit_price])/100
    @created_at = Date.parse(row[:created_at] || "2015-06-23")
    @updated_at = Date.parse(row[:updated_at] || "2015-06-23")
  end

  def invoice
    @invoice_item_repo.find_invoice_by_invoice_id(invoice_id)
  end

  def item
    @invoice_item_repo.find_item_by_item_id(item_id)
  end

  def successful?
    invoice.successful?
  end

end