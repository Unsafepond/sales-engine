require 'minitest/autorun'
require './lib/invoice_item_repository'
require './lib/sales_engine'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_class
    assert InvoiceItemRepository
  end

  def test_find_all_invoice_items
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository
    assert_equal 10, repo.all.count
  end

  def test_find_random_invoices
    skip
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository
    invoice_permutations = repo.all.permutation.to_a
    assert invoice_permutations.include?(repo.random)

  end

  def test_find_invoice_item_by_id
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    ids = repo.find_by_id("1")
    ids.each do |id|
      assert_equal 1, id.id
    end
  end

  def test_find_invoice_by_invoice_id
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    invoice_ids = repo.find_by_invoice_id(2)
    assert_equal 2, invoice_ids.invoice_id
  end

  def test_find_invoice_by_quantity
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    quantity = repo.find_by_quantity(7)
    assert_equal 7, quantity.quantity
  end

  def test_find_invoice_by_unit_price
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    unit_prices = repo.find_by_unit_price(76941)
    assert_equal 76941, unit_prices.unit_price
  end

  def test_find_invoice_by_item_id
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    item_ids = repo.find_by_item_id(541)
    assert_equal 541, item_ids.item_id
  end

  def test_find_invoice_by_created_at
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    created_at = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", created_at.created_at
  end
  def test_find_invoice_by_updated_at
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.invoice_item_repository

    updated_at = repo.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", updated_at.updated_at

  end

  def test_find_all_by_id
    repo       = InvoiceItemRepository.new(
      [{id: 1},
        {id: 1},
        {id: 3}
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

  def test_find_all_by_item_id
    repo       = InvoiceItemRepository.new(
      [{id: 1, item_id: 2, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, item_id: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, item_id: 1, created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    invoice_item_ids = repo.find_all_by_item_id(2)
    invoice_item_ids.each do |invoice_item_id|
      assert_equal 2, invoice_item_ids.map { |invoice_item_id| invoice_item_id.item_id }.count
    end

    invoice_item_ids = repo.find_all_by_item_id(1)
    invoice_item_ids.each do |invoice_item_id|
      assert_equal [1], invoice_item_ids.map { |invoice_item_id| invoice_item_id.item_id }
    end

    invoice_item_ids = repo.find_all_by_item_id(3)
    invoice_item_ids.each do |invoice_item_id|
      assert_equal [], invoice_item_ids.map { |invoice_item_id| invoice_item_id.item_id }
    end
  end
  def test_find_all_by_invoice_id
    repo       = InvoiceItemRepository.new(
      [{id: 1, invoice_id: 2, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, invoice_id: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, invoice_id: 1, created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    invoice_ids = repo.find_all_by_invoice_id(2)
    invoice_ids.each do |invoice_id|
      assert_equal 2, invoice_ids.map { |invoice_id| invoice_id.invoice_id }.count
    end

    invoice_ids = repo.find_all_by_invoice_id(1)
    invoice_ids.each do |invoice_id|
      assert_equal [1], invoice_ids.map { |invoice_id| invoice_id.invoice_id }
    end

    invoice_ids = repo.find_all_by_invoice_id(3)
    invoice_ids.each do |invoice_id|
      assert_equal [], invoice_ids.map { |invoice_id| invoice_id.invoice_id }
    end
  end

  def test_find_all_by_quantity
    repo       = InvoiceItemRepository.new(
      [{id: 1, quantity: 532, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, quantity: 4372, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, quantity: 532, created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    quantitys = repo.find_all_by_quantity(532)
    quantitys.each do |quantity|
      assert_equal 2, quantitys.map { |quantity| quantity.quantity }.count
    end

  end

  def test_find_all_by_unit_price
    repo       = InvoiceItemRepository.new(
      [{id: 1, unit_price: 532, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, unit_price: 4372, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, unit_price: 532, created_at: "2012-03-27 14:53:59 UTC"}
      ]
    )

    unit_prices = repo.find_all_by_unit_price(532)
    unit_prices.each do |unit_price|
      assert_equal 2, unit_prices.map { |unit_price| unit_price.unit_price }.count
    end

  end

  def test_find_all_by_created_at
    repo       = InvoiceItemRepository.new(
      [{id: 1, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, created_at: "2012-03-27 14:53:59 UTC"}
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
    repo       = InvoiceItemRepository.new(
      [{id: 1, updated_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, updated_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, updated_at: "2012-03-27 14:53:59 UTC"}
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
