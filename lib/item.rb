require_relative 'item_repository'

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
    @unit_price = row[:unit_price].to_i
    @merchant_id = row[:merchant_id].to_i
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end
end
# id,name,description,unit_price,merchant_id,
# created_at,updated_at