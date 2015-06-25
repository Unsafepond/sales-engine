require_relative 'sales_engine'
require_relative 'invoice_item'
require 'bigdecimal'
require 'date'

class InvoiceItemRepository
  attr_reader :all

  def initialize(hashes, sales_engine)
    @invoice_items ||= hashes.map { |hash| InvoiceItem.new(hash.to_hash, self)}
    @sales_engine = sales_engine
  end
  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
  def random
    all.shuffle.first
  end
  def all
    @invoice_items
  end
  def find_by_id(id)
    all.find { |invoice_item| invoice_item.id == id }
  end

  def find_by_item_id(item_id)
    all.find { |invoice_item| invoice_item.item_id == item_id}
  end

  def find_by_invoice_id(invoice_id)
    all.find { |invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def find_by_quantity(quantity)
    all.find { |invoice_item| invoice_item.quantity == quantity}
  end

  def find_by_unit_price(unit_price)
    all.find { |invoice_item| invoice_item.unit_price == unit_price}
  end

  def find_by_created_at(created_at)
    all.find { |invoice_item| invoice_item.created_at == Date.parse(created_at)}
  end

  def find_by_updated_at(updated_at)
    all.find { |invoice_item| invoice_item.updated_at == Date.parse(updated_at)}
  end

  def find_all_by_id(id)
    all.select { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    all.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    all.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_quantity(quantity)
    all.select { |invoice_item| invoice_item.quantity == quantity }
  end

  def find_all_by_unit_price(unit_price)
    all.select { |invoice_item| invoice_item.unit_price == unit_price }
  end

  def find_all_by_created_at(created_at)
    all.select { |invoice_item| invoice_item.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    all.select { |invoice_item| invoice_item.updated_at == updated_at }
  end

  def find_invoice_by_invoice_id(invoice_id)
    @sales_engine.find_invoice_by_invoice_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    @sales_engine.find_item_by_item_id(item_id)
  end

  def add_item(items, invoice_id)
    items.each do |i|
      data = {
        :id         => next_id,
        :item_id    => i.id,
        :invoice_id => invoice_id,
        :quantity   => items.count,
        :unit_price => i.unit_price,
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
      }

      @invoice_items << InvoiceItem.new(data, self)

    end
  end

  def next_id
    @invoice_items.last.id + 1
  end
end