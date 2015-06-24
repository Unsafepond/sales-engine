class Customer
  attr_reader :customer_repo, :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(row, customer_repo)
    @customer_repo = customer_repo
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoices
    @customer_repo.find_all_invoices_by_customer_id(id)
  end

  def transactions
    invoices.map {|invoice| invoice.transactions}
  end

  def favorite_merchant
    #need to get all successful transactions
    #count the number per merchant
    #return the merchant that has the most invoices
    # merchants.map {|merchant|merchant}.first
    count_of_merchants.sort_by { |k,v| v}.to_h.keys.first
  end
  def successful_invoices
    invoices.select {|invoice| invoice.successful?}
  end
  def merchants
    successful_invoices.map{|invoice| invoice.merchant}
  end
  def count_of_merchants
    merchants.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
  end


end
