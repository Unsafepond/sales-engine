require 'minitest/autorun'
require './lib/transaction_repository'
require './lib/sales_engine'
require 'pry'

class TransactionRepositoryTest < Minitest::Test

def test_class
    assert TransactionRepository
end

def test_find_all_transactions
    repo = TransactionRepository.new([
    	{id: 1}, {id: 2}, {id: 3},
    	{id: 2}
    	], "fake_sales_engine_self")
    assert_equal 4, repo.all.count
end

def test_find_random_transactions
    repo = TransactionRepository.new([
    	{id: 1}, {id: 2}, {id: 3},
    	{id: 2}
    	], "fake_sales_engine_self")
    transaction_permutations = repo.all.permutation.to_a
    assert transaction_permutations.include?(repo.random)
  end

def test_find_transaction_by_id
    repo = TransactionRepository.new([
    	{id: 1}, {id: 2}, {id: 3},
    	{id: 2}
    	], "fake_sales_engine_self")
    transactions_id = repo.find_by_id(1)
      assert_equal 1, transactions_id.id
  end

  def test_find_transaction_by_invoice_id
    repo = TransactionRepository.new([
    	{invoice_id: 1}, {invoice_id: 2}, {invoice_id: 3},
    	{invoice_id: 2}
    	], "fake_sales_engine_self")
    transactions_invoice_id = repo.find_by_invoice_id(1)
      assert_equal 1, transactions_invoice_id.invoice_id
  end

  def test_find_transaction_by_credit_card_number
    repo = TransactionRepository.new([
    	{credit_card_number: "1"}, {credit_card_number: "2"}, {credit_card_number: "3"},
    	{credit_card_number: "2"}
    	], "fake_sales_engine_self")
    transactions_credit_card_number = repo.find_by_credit_card_number("1")
      assert_equal "1", transactions_credit_card_number.credit_card_number
  end

  def test_find_transaction_by_credit_card_experation_date
    repo = TransactionRepository.new([
    	{credit_card_experation_date: "1"}, {credit_card_experation_date: "2"}, {credit_card_experation_date: "3"},
    	{credit_card_experation_date: "2"}
    	], "fake_sales_engine_self")
    transactions_credit_card_experation_date = repo.find_by_credit_card_experation_date("1")
      assert_equal "1", transactions_credit_card_experation_date.credit_card_experation_date
  end

  def test_find_transaction_by_result
    repo = TransactionRepository.new([
    	{result: "1"}, {result: "2"}, {result: "3"},
    	{result: "2"}
    	], "fake_sales_engine_self")
    transactions_result = repo.find_by_result("1")
      assert_equal "1", transactions_result.result
  end

  def test_find_transaction_by_created_at
    repo = TransactionRepository.new([
    	{created_at: "1"}, {created_at: "2"}, {created_at: "3"},
    	{created_at: "2"}
    	], "fake_sales_engine_self")
    transactions_created_at = repo.find_by_created_at("1")
      assert_equal "1", transactions_created_at.created_at
  end

  def test_find_transaction_by_updated_at
    repo = TransactionRepository.new([
    	{updated_at: "1"}, {updated_at: "2"}, {updated_at: "3"},
    	{updated_at: "2"}
    	], "fake_sales_engine_self")
    transactions_updated_at = repo.find_by_updated_at("1")
      assert_equal "1", transactions_updated_at.updated_at
  end
 
end