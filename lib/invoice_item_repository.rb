require_relative "sales_engine"
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :all

  def initialize(hashes)
    @all = hashes.map { |hash| InvoiceItem.new(hash.to_hash, self)}
  end

  def random
    @all.shuffle
  end

  def find_by_id(id)
    @all.select { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    @all.select { |invoice_item| invoice_item.item_id == item_id}.first
  end

  def find_by_invoice_id(invoice_id)
    @all.select { |invoice_item| invoice_item.invoice_id == invoice_id}.first
  end

  def find_by_quantity(quantity)
    @all.select { |invoice_item| invoice_item.quantity == quantity}.first
  end

  def find_by_unit_price(unit_price)
    @all.select { |invoice_item| invoice_item.unit_price == unit_price}.first
  end

  def find_by_created_at(created_at)
    @all.select { |invoice_item| invoice_item.created_at == created_at}.first
  end

  def find_by_updated_at(updated_at)
    @all.select { |invoice_item| invoice_item.updated_at == updated_at}.first
  end

  def find_all_by_id(id)
    @all.select { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    @all.select { |invoice_item| invoice_item.item_id == item_id }

  end

  def find_all_by_invoice_id(invoice_id)
    @all.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_quantity(quantity)
    @all.select { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_by_unit_price(unit_price)
    @all.select { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_by_created_at(created_at)
    @all.select { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    @all.select { |invoice_item| invoice_item.updated_at == updated_at }
  end


end