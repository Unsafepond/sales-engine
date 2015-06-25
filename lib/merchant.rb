require 'pry'
class Merchant
  attr_reader :merchant_repo, :id, :name, :created_at, :updated_at

  def initialize(row, merchant_repo)
    @merchant_repo = merchant_repo
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def items
    @merchant_repo.find_all_items_by_merchant_id(id)
  end

  def invoices
    @merchant_repo.find_all_invoices_by_merchant_id(id)
  end

  def revenue(date = nil)
    if date
      revenue_by_date(date)
    else
      total_revenue_for_all_dates
    end
  end
  def total_revenue_for_all_dates
    successful_invoices.reduce(0) { |rev, i| rev + i.revenue}
  end
  def revenue_by_date(date)
    successful_invoices.select do |invoice|
      invoice.created_at == date
    end.reduce(0) do |revenue, invoice|
      revenue + invoice.revenue
    end
  end
  def successful_invoice_items
    successful_invoices.map {|invoice| invoice.invoice_items}
  end
  def successful_invoices
    invoices.select { |invoice| invoice.successful?}
  end
  def unsuccessful_invoices
    invoices.select { |invoice|invoice.pending}
  end
  def successful_total_items
    successful_invoice_items.flatten.map {|invoice_item| invoice_item.quantity}.reduce(:+)
  end
  def favorite_customer
    max = count_per_customer.values.max
    count_per_customer.select{ |k,v| v == max}.keys.first
  end
  def customers
    successful_invoices.map {|invoice| invoice.customer}
  end
  def count_per_customer
    customers.inject(Hash.new(0)) { |h, e| h[e] += 1; h}
  end
  def customers_with_pending_invoices
    # a = all_transactions.map{|i|i.id}
    # b = successful_invoices.map{|i|i.id}
    # c = unsuccessful_invoices.map{|i|i.id}
    # a - b - c
    (all_transactions - successful_invoices).map {|invoice| invoice.customer}

    # pending_invoices.map {|invoice| invoice.customer_id == invoice.customer}
  end
  def all_transactions
    invoices
  end
  def pending_invoices
    (all_transactions - successful_invoices)

    #need to filter unsuccessful by successful and
  end

end

