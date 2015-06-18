require 'minitest/autorun'
require './lib/invoice_item_repository'
require './lib/sales_engine'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_class
    assert InvoiceItemRepository
  end

  def test_find_all_invoice_items
    repo       = InvoiceItemRepository.new(
      [{id: 1, item_id: 2, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, item_id: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, item_id: 1, created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )
    assert_equal 3, repo.all.count
  end

  def test_find_random_invoices
    repo       = InvoiceItemRepository.new(
      [{id: 1, item_id: 2, created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )
    assert_equal 1, repo.random.id

  end

  def test_find_invoice_item_by_id
    repo       = InvoiceItemRepository.new(
      [{id: 1},
        {id: 1},
        {id: 3}
      ], "fake sales engine"
    )

    ids = repo.find_by_id(1)

    assert_equal 1, ids.id

  end

  def test_find_invoice_by_invoice_id
    repo       = InvoiceItemRepository.new(
      [{id: 1, invoice_id: 2, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, invoice_id: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, invoice_id: 1, created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )

    invoice_ids = repo.find_by_invoice_id(2)
    assert_equal 2, invoice_ids.invoice_id
  end

  def test_find_invoice_by_quantity
    repo       = InvoiceItemRepository.new(
      [{id: 1, quantity: 2, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, quantity: 2, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, quantity: 1, created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )

    quantity = repo.find_by_quantity(2)

    assert_equal 2, quantity.quantity
    assert_equal 1, quantity.id
  end

  def test_find_invoice_by_unit_price
    repo       = InvoiceItemRepository.new(
      [{id: 1, unit_price: 13635, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, unit_price: 13645, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, unit_price: 13635, created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )

    unit_prices = repo.find_by_unit_price(13635)
    assert_equal 13635, unit_prices.unit_price
  end

  def test_find_invoice_by_item_id
    repo       = InvoiceItemRepository.new(
      [{id: 1, item_id: 543, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, item_id: 643, created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, item_id: 233, created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )

    item_ids = repo.find_by_item_id(543)
    assert_equal 543, item_ids.item_id
  end

  def test_find_invoice_by_created_at
    repo       = InvoiceItemRepository.new(
      [{id: 1, item_id: 543, created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, item_id: 643, created_at: "2012-03-27 14:54:09 UTC"},
        {id: 3, item_id: 233, created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )

    created_at = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", created_at.created_at
  end
  def test_find_invoice_by_updated_at
    repo       = InvoiceItemRepository.new(
      [{id: 1, updated_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, updated_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, updated_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales engine"
    )

    updated_at = repo.find_by_updated_at("1996-08-27 14:53:59 UTC")
    assert_equal "1996-08-27 14:53:59 UTC", updated_at.updated_at

  end

  def test_find_all_by_id
    repo       = InvoiceItemRepository.new(
      [{id: 1},
        {id: 1},
        {id: 3}
      ], "fake sales engine"
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
      ], "fake sales engine"
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
      ], "fake sales engine"
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
      ], "fake sales engine"
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
      ], "fake sales engine"
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
      ], "fake sales engine"
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
      ], "fake sales engine"
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
