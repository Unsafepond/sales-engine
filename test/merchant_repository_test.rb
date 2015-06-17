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

  def test_find_all_by_id
    repo       = MerchantRepository.new(
      [{id: 1, name: "Sylvester"},
        {id: 1, name: "Mary"},
        {id: 3, name: "Sylvester"}
      ]
    )

    ids = repo.find_all_by_id("1")
    ids.each do |id|
      assert_equal [1,2], ids.map { |id| id.id }
    end

    ids = repo.find_all_by_id("3")
    ids.each do |id|
      assert_equal [3], ids.map { |id| id.id }
    end

    ids = repo.find_all_by_id("4")
    ids.each do |id|
      assert_equal [], ids.map { |id| id.id }
    end
  end

  def test_find_all_by_name
    repo       = MerchantRepository.new(
      [{id: 1, name: "Mike", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, name: "Jerrod", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, name: "Mike", created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    names = repo.find_all_by_name("Mike")
    names.each do |name|
      assert_equal 2, names.map { |name| name.name }.count
    end

    names = repo.find_all_by_name("Jerrod")
    names.each do |name|
      assert_equal ["Jerrod"], names.map { |name| name.name }
    end

    names = repo.find_all_by_name("Tim")
    names.each do |name|
      assert_equal [], names.map { |name| name.name }
    end
  end

  def test_find_all_by_created_at
    repo       = MerchantRepository.new(
      [{id: 1, name: "Mike", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, name: "Jerrod", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, name: "Mike", created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    created_ats = repo.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    created_ats.each do |created_at|
      assert_equal 2, created_ats.map { |created_at| created_at.created_at }.count
    end

    created_ats = repo.find_all_by_created_at("Jerrod")
    created_ats.each do |created_at|
      assert_equal ["Jerrod"], created_ats.map { |created_at| created_at.created_at }
    end

    created_ats = repo.find_all_by_created_at("Tim")
    created_ats.each do |created_at|
      assert_equal [], created_ats.map { |created_at| created_at.created_at }
    end
  end

  def test_find_all_by_updated_at
    repo       = MerchantRepository.new(
      [{id: 1, name: "Mike", updated_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, name: "Jerrod", updated_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, name: "Mike", updated_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    updated_ats = repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    updated_ats.each do |updated_at|
      assert_equal 2, updated_ats.map { |updated_at| updated_at.updated_at }.count
    end

    updated_ats = repo.find_all_by_updated_at("Jerrod")
    updated_ats.each do |updated_at|
      assert_equal ["Jerrod"], updated_ats.map { |updated_at| updated_at.updated_at }
    end

    updated_ats = repo.find_all_by_updated_at("Tim")
    updated_ats.each do |updated_at|
      assert_equal [], updated_ats.map { |updated_at| updated_at.updated_at }
    end
  end


end