require_relative 'transaction_repository'

class Transaction
  attr_reader :item_repo,
              :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_experation_date,
              :result, 
              :created_at,
              :updated_at

  def initialize(row, item_repo)
    @item_repo = item_repo
    @id = row[:id].to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = row[:credit_card_number]
    @credit_card_experation_date = row[:credit_card_experation_date]
    @result = row[:result]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end
end
# id,invoice_id,credit_card_number,credit_card_expiration_date,
#result,created_at,updated_at