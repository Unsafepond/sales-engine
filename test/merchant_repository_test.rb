require 'minitest/autorun'
require './lib/merchant_repository'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_class
    assert MerchantRepository
  end

  def test_find_all_merchants
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository
    assert_equal 5, repo.all.count

  end

  def test_find_random_merchants
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository
    merchant_permutations = repo.all.permutation.to_a
      assert merchant_permutations.include?(repo.random)

  end

  def test_find_merchant_by_id
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    ids = repo.find_by_id("2")
    ids.each do |id|
      assert_equal 2, id.id
    end
  end
  def test_find_merchant_by_name
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    names = repo.find_by_name("Schroeder-Jerde")
    names.each do |name|
      assert_equal "Schroeder-Jerde", repo.find_by_name("Schroeder-Jerde")
    end
  end
  def test_find_merchant_by_created_at
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    created_at = repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    created_at.each do |create|
      assert_equal "2012-03-27 14:53:59 UTC", create.created_at
    end
      created_at = repo.find_by_created_at("2012-03-2 14:53:59 UTC")
      created_at.each do |create|
        assert_equal "", create.created_at
    end
  end
  def test_find_merchant_by_updated_at
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    updated_at = repo.find_by_updated_at("2012-03-27 14:53:59 UTC")
    updated_at.each do |update|
      assert_equal "2012-03-27 14:53:59 UTC", update.updated_at
    end

    updated_at = repo.find_by_updated_at("2012-27 14:53:59 UTC")
    updated_at.each do |update|
      assert_equal "", update.updated_at
    end
  end




end