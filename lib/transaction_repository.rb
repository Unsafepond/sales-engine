require_relative 'sales_engine'
require_relative 'transaction'
require 'bigdecimal'

class TransactionRepository

  attr_reader :all
  def initialize(hashes, sales_engine)
    @transactions ||= hashes.map { |hash| Transaction.new(hash.to_hash, self)}
    @sales_engine = sales_engine
  end
  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
  def random
    all.shuffle.first
  end
  def all
    @transactions
  end
  def find_by_id(id)
    all.find { |transaction| transaction.id == id }
  end
  def find_all_by_id(id)
    all.select { |transaction| transaction.id == id }
  end
  def find_by_invoice_id(invoice_id)
    all.find { |transaction| transaction.invoice_id == invoice_id }
  end
  def find_all_by_invoice_id(invoice_id)
    all.select { |transaction| transaction.invoice_id == invoice_id }
  end
  def find_by_credit_card_number(credit_card_number)
    all.find { |transaction| transaction.credit_card_number == credit_card_number }
  end
  def find_all_by_credit_card_number(credit_card_number)
    all.select { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    all.find do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    all.select do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_by_result(result)
    all.find { |transaction| transaction.result == result }
  end

  def find_all_by_result(result)
    all.select { |transaction| transaction.result == result }
  end

  def find_by_created_at(created_at)
    all.find { |transaction| transaction.created_at == created_at }
  end

  def find_all_by_created_at(created_at)
    all.select { |transaction| transaction.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    all.find { |transaction| transaction.updated_at == updated_at }
  end

  def find_all_by_updated_at(updated_at)
    all.select { |transaction| transaction.updated_at == updated_at }
  end

  def find_invoice_by_invoice_id(invoice_id)
    @sales_engine.find_invoice_by_invoice_id(invoice_id)
  end

  def charge(inputs, invoice_id)
    data = {
      :id => next_id,
      :invoice_id => invoice_id,
      :credit_card_number => inputs[:credit_card_number],
      :credit_card_expiration_date => inputs[:credit_card_expiration],
      :result => inputs[:result],
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
    }

    new_transaction = Transaction.new(data, self)
    @transactions.push(new_transaction)
  end

  def next_id
    @transactions.last.id + 1
  end
end