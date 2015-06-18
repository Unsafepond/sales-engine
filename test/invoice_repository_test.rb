require 'minitest/autorun'
require './lib/invoice_repository'
require './lib/sales_engine'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_class
    assert InvoiceRepository
  end

  def test_find_all_invoices
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository
    assert_equal 10, repo.all.count

  end

  def test_find_random_invoices
    skip
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository
    invoice_permutations = repo.all.permutation.to_a
    assert invoice_permutations.include?(repo.random)

  end

  def test_find_invoice_by_id
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository

    ids = repo.find_by_id("1")
    ids.each do |id|
      assert_equal 1, id.id
    end
  end

  def test_find_invoice_by_customer_id
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository

    customer_ids = repo.find_by_customer_id(2)
    assert_equal 2, customer_ids.customer_id
  end

  def test_find_invoice_by_status
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository

    status = repo.find_by_status("shipped")
    assert_equal "shipped", status.status
  end

  def test_find_invoice_by_merchant_id
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository

    merchant_ids = repo.find_by_merchant_id(44)
    assert_equal 44, merchant_ids.merchant_id
  end

  def test_find_invoice_by_created_at
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository

    created_at = repo.find_by_created_at("2012-03-12 05:54:09 UTC")
      assert_equal "2012-03-12 05:54:09 UTC", created_at.created_at
  end
  def test_find_invoice_by_updated_at
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_repository

    updated_at = repo.find_by_updated_at("2012-03-10 00:54:09 UTC")
    assert_equal "2012-03-10 00:54:09 UTC", updated_at.updated_at

  end

  def test_find_all_by_id
    repo       = InvoiceRepository.new(
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

  def test_find_all_by_customer_id
    repo       = InvoiceRepository.new(
      [{id: 1, customer_id: 2, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, customer_id: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, customer_id: 1, created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    customer_ids = repo.find_all_by_customer_id(2)
    customer_ids.each do |customer_id|
      assert_equal 2, customer_ids.map { |customer_id| customer_id.customer_id }.count
    end

    customer_ids = repo.find_all_by_customer_id(1)
    customer_ids.each do |customer_id|
      assert_equal [1], customer_ids.map { |customer_id| customer_id.customer_id }
    end

    customer_ids = repo.find_all_by_customer_id(3)
    customer_ids.each do |customer_id|
      assert_equal [], customer_ids.map { |customer_id| customer_id.customer_id }
    end
  end
  def test_find_all_by_merchant_id
    repo       = InvoiceRepository.new(
      [{id: 1, merchant_id: 2, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, merchant_id: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    merchant_ids = repo.find_all_by_merchant_id(2)
    merchant_ids.each do |merchant_id|
      assert_equal 2, merchant_ids.map { |merchant_id| merchant_id.merchant_id }.count
    end

    merchant_ids = repo.find_all_by_merchant_id(1)
    merchant_ids.each do |merchant_id|
      assert_equal [1], merchant_ids.map { |merchant_id| merchant_id.merchant_id }
    end

    merchant_ids = repo.find_all_by_merchant_id(3)
    merchant_ids.each do |merchant_id|
      assert_equal [], merchant_ids.map { |merchant_id| merchant_id.merchant_id }
    end
  end

  def test_find_all_by_status
    repo       = InvoiceRepository.new(
      [{id: 1, status: "shipped", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, status: "shipped", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, status: "shipped", created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    statuss = repo.find_all_by_status("shipped")
    statuss.each do |status|
      assert_equal 3, statuss.map { |status| status.status }.count
    end

  end

  def test_find_all_by_created_at
    repo       = InvoiceRepository.new(
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
    repo       = InvoiceRepository.new(
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
