require_relative "sales_engine"
require_relative 'transactions'

class TransactionRepository

	attr_reader :all
	def initialize(hashes)
    	@all = hashes.map { |hash| Item.new(hash.to_hash, self)}
  	end

  	def random
    	@all.shuffle
 	end

 	def find_by_id(id)
    	@all.find { |transaction| transaction.id == id }
  	end

  	def find_by_invoice_id(invoice_id)
    	@all.find { |transaction| transaction.invoice_id == invoice_id }
  	end

  	def find_by_credit_card_number(credit_card_number)
    	@all.find { |transaction| transaction.credit_card_number == credit_card_number }
  	end

  	def find_by_credit_card_experation_date(credit_card_experation_date)
    	@all.find { |transaction| transaction.credit_card_experation_date == credit_card_experation_date }
  	end

  	def find_by_result(result)
    	@all.find { |transaction| transaction.result == result }
  	end

  	def find_by_created_at(created_at)
    	@all.find { |transaction| transaction.created_at == created_at }
  	end

  	def find_by_updated_at(updated_at)
    	@all.find { |transaction| transaction.updated_at == updated_at }
  	end
end