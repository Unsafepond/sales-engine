require 'csv'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
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
                :invoice_item_repository,
                :item_repository,
                :customer_repository,
                :transaction_repository

  def startup
    merchants = parse('merchants.csv')
    invoice_items = parse('invoice_items.csv')
    invoices = parse('invoices.csv')
    customers = parse('customers.csv')
    items = parse('items.csv')
    transactions = parse('transactions.csv')

    @merchant_repository      = MerchantRepository.new(merchants, self)
    @invoice_repository       = InvoiceRepository.new(invoices, self)
    @item_repository         = ItemRepository.new(items, self)
    @invoice_item_repository  = InvoiceItemRepository.new(invoice_items, self)
    @customer_repository      = CustomerRepository.new(customers, self)
    @transaction_repository   = TransactionRepository.new(transactions, self)
  end

  def find_all_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_all_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_all_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_invoice_by_invoice_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_all_invoice_items_by_item_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_merchant_by_merchant_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoice_by_invoice_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_item_by_item_id(id)
    item_repository.find_by_id(id)
  end

  def find_invoice_merchant_with_merchant_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoice_customer_with_customer_id(id)
    customer_repository.find_by_id(id)
  end

  def find_invoices_invoice_items(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_invoices_transactions(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_items_in_invoice(id)
    find_invoices_invoice_items(id).item_id

  end



  private

  def parse(filename)
    CSV.read "#{@data_dir}/#{filename}", headers: true, header_converters: :symbol
  end

end

