# Take
#
require 'csv'
require 'pry'
require 'bigdecimal'
# require_relative 'parser'
require_relative 'merchant'
require_relative 'sales_engine'


class MerchantRepository
  attr_reader :merchants,
              :all
  def initialize(hashes, sales_engine)
    @merchants = hashes.map { |hash| Merchant.new(hash.to_hash, self)}
    @sales_engine = sales_engine
  end
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  def all
    @merchants
  end
  def find_all_by_name(name)
    all.select { |merchant| merchant.name == name }
  end

  def random
    all.shuffle.first
  end

  def find_by_id(id)
    all.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    all.find { |merchant| merchant.name == name }
  end

  def find_by_created_at(create_date)
    all.find { |merchant| merchant.created_at == create_date }
  end

  def find_by_updated_at(update_date)
    all.find { |merchant| merchant.updated_at == update_date }
  end

  def find_all_by_id(id)
    all.select { |merchant| merchant.id == id }
  end

  def find_all_by_created_at(created_at)
    all.select { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    all.select { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_items_by_merchant_id(id)
    @sales_engine.find_all_items_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    @sales_engine.find_all_invoices_by_merchant_id(id)
  end

  def revenue(date)
    all.map { |merchant| merchant.revenue_by_date(date)}
      .reduce(0) { |total, revenue| total + revenue }
  end

  def most_revenue(quantity)
    all.group_by {|merchant| merchant.revenue}.sort_by { |k,v| k}.to_h.values.last(quantity).flatten.reverse
  end
  def revenues
    all.map {|merchant| merchant.revenue}
  end
  def most_items(quantity)
    all.group_by {|merchant| merchant.successful_total_items}
      .sort_by { |k,v| k}.to_h.values.last(quantity)
        .flatten.reverse
  end


end


