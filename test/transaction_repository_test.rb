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
    	{id: 1}
    	], "fake_sales_engine_self")
    assert_equal 1, repo.random.id
  end

def test_find_transaction_by_id
    repo = TransactionRepository.new([
    	{id: 1}, {id: 2}, {id: 3},
    	{id: 2}
    	], "fake_sales_engine_self")
    transactions_id = repo.find_by_id(1)
      assert_equal 1, transactions_id.id
  end

  def test_find_all_by_id
    repo       = TransactionRepository.new([ 
    	{id: "string"},
        {id: "string"},
        {id: "other string"}
      ], "fake_sales_engine"
    )

    ids = repo.find_all_by_id("string")
    ids.each do |id|
      assert_equal ["string", "string"], ids.map { |id| id.id }
    end

    ids = repo.find_all_by_id("other string")
    ids.each do |id|
      assert_equal ["other string"], ids.map { |id| id.id }
    end

    ids = repo.find_all_by_id("jjhjkhj")
    ids.each do |id|
      assert_equal [], ids.map { |id| id.id }
    end
  end

  def test_find_transaction_by_invoice_id
    repo = TransactionRepository.new([
    	{invoice_id: 1}, {invoice_id: 2}, {invoice_id: 3},
    	{invoice_id: 2}
    	], "fake_sales_engine_self")
    transactions_invoice_id = repo.find_by_invoice_id(1)
      assert_equal 1, transactions_invoice_id.invoice_id
  end

  def test_find_all_by_invoice_id
    repo       = TransactionRepository.new([ 
    	{invoice_id: "string"},
        {invoice_id: "string"},
        {invoice_id: "other string"}
      ], "fake_sales_engine"
    )

    invoice_ids = repo.find_all_by_invoice_id("string")
    invoice_ids.each do |invoice_id|
      assert_equal ["string", "string"], invoice_ids.map { |invoice_id| invoice_id.invoice_id }
    end

    invoice_ids = repo.find_all_by_invoice_id("other string")
    invoice_ids.each do |invoice_id|
      assert_equal ["other string"], invoice_ids.map { |invoice_id| invoice_id.invoice_id }
    end

    invoice_ids = repo.find_all_by_invoice_id("jjhjkhj")
    invoice_ids.each do |invoice_id|
      assert_equal [], invoice_ids.map { |invoice_id| invoice_id.invoice_id }
    end
  end

  def test_find_transaction_by_credit_card_number
    repo = TransactionRepository.new([
    	{credit_card_number: "1"}, {credit_card_number: "2"}, {credit_card_number: "3"},
    	{credit_card_number: "2"}
    	], "fake_sales_engine_self")
    transactions_credit_card_number = repo.find_by_credit_card_number("1")
      assert_equal "1", transactions_credit_card_number.credit_card_number
  end

  def test_find_all_by_credit_card_number
    repo       = TransactionRepository.new([ 
    	{credit_card_number: "string"},
        {credit_card_number: "string"},
        {credit_card_number: "other string"}
      ], "fake_sales_engine"
    )

    credit_card_numbers = repo.find_all_by_credit_card_number("string")
    credit_card_numbers.each do |credit_card_number|
      assert_equal ["string", "string"], credit_card_numbers.map { |credit_card_number| credit_card_number.credit_card_number }
    end

    credit_card_expiration_dates = repo.find_all_by_credit_card_expiration_date("other string")
    credit_card_expiration_dates.each do |credit_card_expiration_date|
      assert_equal ["other string"], credit_card_expiration_dates.map { |credit_card_expiration_date| credit_card_expiration_date.credit_card_expiration_date }
    end

    credit_card_expiration_dates = repo.find_all_by_credit_card_expiration_date("jjhjkhj")
    credit_card_expiration_dates.each do |credit_card_expiration_date|
      assert_equal [], credit_card_expiration_dates.map { |credit_card_expiration_date| credit_card_expiration_date.credit_card_expiration_date }
    end
  end

  def test_find_transaction_by_credit_card_expiration_date
    repo = TransactionRepository.new([
    	{credit_card_expiration_date: "1"}, {credit_card_expiration_date: "2"}, {credit_card_expiration_date: "3"},
    	{credit_card_expiration_date: "2"}
    	], "fake_sales_engine_self")
    transactions_credit_card_expiration_date = repo.find_by_credit_card_expiration_date("1")
      assert_equal "1", transactions_credit_card_expiration_date.credit_card_expiration_date
  end

  def test_find_all_by_credit_card_expiration_date
    repo       = TransactionRepository.new([ 
    	{credit_card_expiration_date: "string"},
        {credit_card_expiration_date: "string"},
        {credit_card_expiration_date: "other string"}
      ], "fake_sales_engine"
    )

    credit_card_expiration_dates = repo.find_all_by_credit_card_expiration_date("string")
    credit_card_expiration_dates.each do |credit_card_expiration_date|
      assert_equal ["string", "string"], credit_card_expiration_dates.map { |credit_card_expiration_date| credit_card_expiration_date.credit_card_expiration_date }
    end

    credit_card_expiration_dates = repo.find_all_by_credit_card_expiration_date("other string")
    credit_card_expiration_dates.each do |credit_card_expiration_date|
      assert_equal ["other string"], credit_card_expiration_dates.map { |credit_card_expiration_date| credit_card_expiration_date.credit_card_expiration_date }
    end

    credit_card_expiration_dates = repo.find_all_by_credit_card_expiration_date("jjhjkhj")
    credit_card_expiration_dates.each do |credit_card_expiration_date|
      assert_equal [], credit_card_expiration_dates.map { |credit_card_expiration_date| credit_card_expiration_date.credit_card_expiration_date }
    end
  end

  def test_find_transaction_by_result
    repo = TransactionRepository.new([
    	{result: "1"}, {result: "2"}, {result: "3"},
    	{result: "2"}
    	], "fake_sales_engine_self")
    transactions_result = repo.find_by_result("1")
      assert_equal "1", transactions_result.result
  end

  def test_find_all_by_result
    repo       = TransactionRepository.new([ 
    	{result: "string"},
        {result: "string"},
        {result: "other string"}
      ], "fake_sales_engine"
    )

    results = repo.find_all_by_result("string")
    results.each do |result|
      assert_equal ["string", "string"], results.map { |result| result.result }
    end

    results = repo.find_all_by_result("other string")
    results.each do |result|
      assert_equal ["other string"], results.map { |result| result.result }
    end

    results = repo.find_all_by_result("jjhjkhj")
    results.each do |result|
      assert_equal [], results.map { |result| result.result }
    end
  end

  def test_find_transaction_by_created_at
    repo = TransactionRepository.new([
    	{created_at: "1"}, {created_at: "2"}, {created_at: "3"},
    	{created_at: "2"}
    	], "fake_sales_engine_self")
    transactions_created_at = repo.find_by_created_at("1")
      assert_equal "1", transactions_created_at.created_at
  end

  def test_find_all_by_created_at
    repo       = TransactionRepository.new([ 
    	{created_at: "string"},
        {created_at: "string"},
        {created_at: "other string"}
      ], "fake_sales_engine"
    )

    created_ats = repo.find_all_by_created_at("string")
    created_ats.each do |created_at|
      assert_equal ["string", "string"], created_ats.map { |created_at| created_at.created_at }
    end

    created_ats = repo.find_all_by_created_at("other string")
    created_ats.each do |created_at|
      assert_equal ["other string"], created_ats.map { |created_at| created_at.created_at }
    end

    created_ats = repo.find_all_by_created_at("jjhjkhj")
    created_ats.each do |created_at|
      assert_equal [], created_ats.map { |created_at| created_at.created_at }
    end
  end

  def test_find_transaction_by_updated_at
    repo = TransactionRepository.new([
    	{updated_at: "1"}, {updated_at: "2"}, {updated_at: "3"},
    	{updated_at: "2"}
    	], "fake_sales_engine_self")
    transactions_updated_at = repo.find_by_updated_at("1")
      assert_equal "1", transactions_updated_at.updated_at
  end

  def test_find_all_by_updated_at
    repo       = TransactionRepository.new([ 
    	{updated_at: "string"},
        {updated_at: "string"},
        {updated_at: "other string"}
      ], "fake_sales_engine"
    )

    updated_ats = repo.find_all_by_updated_at("string")
    updated_ats.each do |updated_at|
      assert_equal ["string", "string"], updated_ats.map { |updated_at| updated_at.updated_at }
    end

    updated_ats = repo.find_all_by_updated_at("other string")
    updated_ats.each do |updated_at|
      assert_equal ["other string"], updated_ats.map { |updated_at| updated_at.updated_at }
    end

    updated_ats = repo.find_all_by_updated_at("jjhjkhj")
    updated_ats.each do |updated_at|
      assert_equal [], updated_ats.map { |updated_at| updated_at.updated_at }
    end
  end

  def test_pass_invoice_id_up_to_sales_engine
    sales_engine = Minitest::Mock.new
    repo = TransactionRepository.new([{id: 23, invoice_id: 231}], sales_engine)
    sales_engine.expect(:find_invoice_by_invoice_id, [], [231])
    repo.find_invoice_by_invoice_id(231)
    sales_engine.verify
  end
 
end