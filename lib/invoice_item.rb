require_relative 'invoice_itme_repository'

class InvoiceItem
  attr_reader :invoice_item_repo, :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(row, invoice_repo)
    @invoice_repo = invoice_repo
    @id = row[:id].to_i
    @item_id = row[:item_id].to_i
    @invoice_id = row[:invoice_id].to_i
    @quantity = row[:quantity]
    @unit_price = row[:unit_price]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end
end