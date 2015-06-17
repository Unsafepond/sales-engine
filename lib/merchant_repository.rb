# Take
#
require 'csv'
require 'pry'
# require_relative 'parser'
require_relative 'merchant'
require_relative 'sales_engine'


class MerchantRepository
  attr_reader :merchants
  def initialize(hashes)
    @all = hashes.map { |hash| Merchant.new(hash.to_hash, self)}
  end

  def find_all_by_name(name)
    @all.select { |merchant| merchant.name == name}
  end




end


