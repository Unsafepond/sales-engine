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
  

  def test_startup_creates_item_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.item_repository

    items = repo.find_all_by_item_id(523)
    items.each do |item|
      assert_equal 523, item.item_id
      assert_equal 3, item.id
    end
  end

  def test_startup_creates_mechant_repo
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    assert_equal MerchantRepository, repo.class
  end

end







































