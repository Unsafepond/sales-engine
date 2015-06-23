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
end
# id,name,description,unit_price,merchant_id,
# created_at,updated_at