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


  def test_startup_creates_merchant_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    assert_equal MerchantRepository, repo.class
  end

end







































