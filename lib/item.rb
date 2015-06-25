require_relative 'item_repository'
require 'bigdecimal'

class Item
  attr_reader :item_repo,
              :id,
              :name,
              :description,
              :unit_price,
              :merchant_id, 
              :created_at,
              :updated_at

  def initialize(row, item_repo)
    @item_repo = item_repo
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price])/100
    @merchant_id = row[:merchant_id].to_i
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoice_items
    item_repo.find_all_invoice_items_by_item_id(id)
  end

  def merchant
    item_repo.find_merchant_by_merchant_id(merchant_id)
  end

  def best_day
    max = invoice_items.max_by { |invoice_item| invoice_item.quantity }
    max.invoice.created_at
  end
  def successful_invoice_items
    invoice_items.select { |invoice_item| invoice_item.successful?}
  end
  def total_revenue
    successful_invoice_items.reduce(0) do |total, invoice_item|
      total + (invoice_item.quantity * invoice_item.unit_price)
    end
  end
  def quantity_sold
    item = successful_invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end
    item.reduce(0) do |sum, i_item|
      sum + i_item.quantity
    end
  end


end
# id,name,description,unit_price,merchant_id,
# created_at,updated_at