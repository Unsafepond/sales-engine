require 'minitest/autorun'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_class
    assert SalesEngine
  end

  def test_startup_creates_mechant_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    names = repo.find_all_by_name("Schroeder-Jerde")
    names.each do |name|
      assert_equal "Schroeder-Jerde", name.name
    end
  end

  def test_startup_creates_invoice_item_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    invoice_items = repo.find_all_by_item_id(1)
    invoice_items.each do |invoice_item|
      assert_equal 1, invoice_item.item_id
      assert_equal 1, invoice_item.id
    end
  end

  def test_startup_creates_items_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.item_repository

    items = repo.find_all_by_merchant_id(1)

    assert_equal 11, items.count

  end

  def test_startup_creates_customer_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.customer_repository

    first_names = repo.find_all_by_first_name("Heber")

    assert_equal 1, first_names.count

  end

  def test_startup_creates_transactions_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.transaction_repository

    results = repo.find_all_by_result("failed")

    assert_equal 2, results.count

  end

  def test_startup_creates_invoices_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository

    results = repo.find_all_by_customer_id(1)

    assert_equal 8, results.count

  end


  def test_startup_creates_merchant_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    assert_equal MerchantRepository, repo.class
  end

  def test_sales_engine_can_get_all_items_by_merchant_id
    sales_engine = SalesEngine.new("data_dir")
    repo = ItemRepository.new([{id: 1, merchant_id: 23}], sales_engine)
    sales_engine.item_repository = repo
    result = sales_engine.find_all_items_by_merchant_id(23)
    assert_equal 1, result[0].id
  end

  def test_sales_engine_can_get_all_invoices_by_merchant_id
    sales_engine = SalesEngine.new("data_dir")
    repo = InvoiceRepository.new([{id: 1, merchant_id: 314}], sales_engine)
    sales_engine.invoice_repository = repo
    result = sales_engine.find_all_invoices_by_merchant_id(314)
    assert_equal 1, result[0].id
  end

  def test_sales_engine_can_get_all_invoices_by_customer_id
    sales_engine = SalesEngine.new("data_dir")
    repo = InvoiceRepository.new([{id: 1, customer_id: 23}], sales_engine)
    sales_engine.invoice_repository = repo
    result = sales_engine.find_all_invoices_by_customer_id(23)
    assert_equal 1, result[0].id
  end

  def test_sales_engine_can_get_invoice_by_invoice_id
    sales_engine = SalesEngine.new("data_dir")
    repo = InvoiceRepository.new([{id: 3, customer_id: 23}], sales_engine)
    sales_engine.invoice_repository = repo
    result = sales_engine.find_invoice_by_invoice_id(3)
    assert_equal 23, result.customer_id

  end

  def test_sales_engine_can_get_all_invoice_items_by_item_id
    sales_engine = SalesEngine.new("data_dir")
    repo = InvoiceItemRepository.new([{id: 1, item_id: 23}], sales_engine)
    sales_engine.invoice_item_repository = repo
    result = sales_engine.find_all_invoice_items_by_item_id(23)
    assert_equal 1, result[0].id
  end

  def test_sales_engine_can_get_merchant_by_merchant_id
    sales_engine = SalesEngine.new("data_dir")
    repo = MerchantRepository.new([{id: 1}], sales_engine)
    sales_engine.merchant_repository = repo
    result = sales_engine.find_merchant_by_merchant_id(1)
    assert_equal 1, result.id
  end

  def test_sales_engine_can_get_invoice_by_invoice_id
    sales_engine = SalesEngine.new("data_dir")
    repo = InvoiceRepository.new([{id: 1}], sales_engine)
    sales_engine.invoice_repository = repo
    result = sales_engine.find_invoice_by_invoice_id(1)
    assert_equal 1, result.id
  end


end







































