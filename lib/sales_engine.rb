require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require 'pry'
# etc
#  read files for each type of supplied csv
#  send the raw data to respective repository
#  respond to methods in test harness that accesses data from any data point
class SalesEngine
  def initialize(data_dir)
    @data_dir = data_dir
  end

  attr_accessor :merchant_repository,
                :invoice_repository,
                :invoice_item_repository


  def startup
    hashes = CSV.read "#{@data_dir}/merchants.csv", headers: true, header_converters: :symbol
    hashes2 = CSV.read "#{@data_dir}/invoices.csv", headers: true, header_converters: :symbol
    # hashes3 = CSV.read "#{@data_dir}/items.csv", headers: true, header_converters: :symbol
    hashes4 = CSV.read "#{@data_dir}/invoice_items.csv", headers: true, header_converters: :symbol
    # hashes5 = CSV.read "#{@data_dir}/customers.csv", headers: true, header_converters: :symbol
    # hashes6 = CSV.read "#{@data_dir}/transactions.csv", headers: true, header_converters: :symbol
    @merchant_repository      = MerchantRepository.new(hashes)
    @invoice_repository      = InvoiceRepository.new(hashes2)
    # @items_repository      = ItemsRepository.new(hashes3)
    @invoice_item_repository = InvoiceItemRepository.new(hashes4)
    # @customer_repository = CustomerRepository.new(hashes5)
    # @transaction_repository = TransactionRepository.new(hashes6)
  end
end

