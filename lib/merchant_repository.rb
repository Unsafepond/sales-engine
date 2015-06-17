# Take
#
require 'csv'
require 'pry'
# require_relative 'parser'
require_relative 'merchant'
require_relative 'sales_engine'


class MerchantRepository
  attr_reader :merchants,
              :all
  def initialize(hashes)
    @all = hashes.map { |hash| Merchant.new(hash.to_hash, self)}
  end

  def find_all_by_name(name)
    @all.select { |merchant| merchant.name == name }
  end

  def random
    @all.shuffle
  end

  def find_by_id(id)
    @all.select { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @all.select { |merchant| merchant.name == name }
  end

  def find_by_created_at(create_date)
    @all.select { |merchant| merchant.created_at == create_date }
  end

  def find_by_updated_at(update_date)
    @all.select { |merchant| merchant.updated_at == update_date }
  end

  def find_all_by_id(id)
    @all.select { |merchant| merchant.id == id }
  end

  def find_all_by_created_at(created_at)
    @all.select { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_updated_at(updated_at)
    @all.select { |merchant| merchant.updated_at == updated_at }
  end




end


