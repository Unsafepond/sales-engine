require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require 'pry'
# etc
#  read files for each type of supplied csv
#  send the raw data to respective repository
#  respond to methods in test harness that accesses data from any data point
class SalesEngine
  def initialize(data_dir)
    @data_dir = data_dir
  end

  attr_accessor :merchant_repository

  # def read_file(file)
  #   # file = "/data/merchants.csv"
  #
  #   CSV.open file, headers: true, header_converters: :symbol
  #
  # end
#  def initialize(data_dir)
#     @data_dir = data_dir
#   end
#
#   attr_accessor :customer_repository
#
#   def startup
#

  def startup
    hashes = CSV.read "#{@data_dir}/merchants.csv", headers: true, header_converters: :symbol
    @merchant_repository      = MerchantRepository.new(hashes)


  end
end

# class Record
# attr_accessor :attributes
# def initialize(attributes)
#   self.attributes = attributes
# end
#
# def id
#   attributes[:id]
# end
#
# end
#
#
# class Merchant < Record
# end
#
# class Invoice < Record
# end
#
# class Item < Record
# end
#
# class InvoiceItem < Record
# end
#
# class Transaction < Record
# end
#
# class Customer < Record
#   def first_name
#     attributes[:first_name]
#   end
#
# end
#
# class CustomerRepository < Repository
#   def record_class
#     Customer
#   end
#
#   def find_all_by_first_name(first_name)
#     @all.select { |customer| customer.first_name == first_name }
#   end
# end
#
# class MerchantRepository < Repository
#   def record_class
#     Merchant
#   end
# end
#
# class InvoiceRepository < Repository
#   def record_class
#     Invoice
#   end
# end
#
# class ItemRepository < Repository
#   def record_class
#     Item
#   end
# end
#
# class InvoiceItemRepository < Repository
#   def record_class
#     InvoiceItem
#   end
# end
#
# class TransactionRepository < Repository
#   def record_class
#     Transaction
#   end
# end
#
# class SalesEngine
#
#
#
# end
#


