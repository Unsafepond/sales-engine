class Customer
  attr_reader :customer_repo, :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(row, merchant_repo)
    @merchant_repo = merchant_repo
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

end
