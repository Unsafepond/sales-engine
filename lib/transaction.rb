require_relative 'transaction_repository'

class Transaction
  attr_reader :transaction_repo,
              :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result, 
              :created_at,
              :updated_at

  def initialize(row, transaction_repo)
    @transaction_repo = transaction_repo
    @id = row[:id].to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = row[:credit_card_number]
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def invoice
    @transaction_repo.find_invoice_by_invoice_id(invoice_id)
  end

  def success?
    result == "success"
  end
  def failed
    result != "success"
  end
end
# id,invoice_id,credit_card_number,credit_card_expiration_date,
#result,created_at,updated_at