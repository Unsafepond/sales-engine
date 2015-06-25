require 'minitest/autorun'
require './lib/item_repository'
require './lib/sales_engine'
require 'ostruct'
require 'pry'
# id,name,description,unit_price,merchant_id,
# created_at,updated_at
class ItemRepositoryTest < Minitest::Test

def test_class
    assert ItemRepository
  end

  def test_find_all_items
    repo = ItemRepository.new([
    	{id: 1, unit_price: "43215"}, {id: 2, unit_price: "43215"}, {id: 3, unit_price: "43215"},
    	{id: 2, unit_price: "43215"}
    	], "fake_sales_engine")
    assert_equal 4, repo.all.count
end

 def test_find_random_items
    repo = ItemRepository.new([
    	{id: 1, unit_price: "43215"}
    	], "fake_sales_engine")

    assert_equal 1, repo.random.id
  end

  def test_find_item_by_id
    repo = ItemRepository.new([
    	{id: 1,unit_price: "43215"}, {id: 2, unit_price: "43215"}, {id: 3, unit_price: "43215"},
    	{id: 2, unit_price: "43215"}
    	], "fake_sales_engine")
    items_id = repo.find_by_id(1)
      assert_equal 1, items_id.id
  end

  def test_find_all_by_id
    repo       = ItemRepository.new([ 
    	{id: 1, unit_price: "43215"},
        {id: 1, unit_price: "43215"},
        {id: 3, unit_price: "43215"}
      ], "fake_sales_engine"
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

def test_find_item_by_name
    repo = ItemRepository.new([
   	{name: "name1", unit_price: "43215"}, {name: "name2", unit_price: "43215"}, {name: "name3", unit_price: "43215"},
   	{name: "name2", unit_price: "43215"}
   	], "fake_sales_engine")
    items_name = repo.find_by_name("name1")
      assert_equal "name1", items_name.name
  end

  def test_find_all_by_name
    repo       = ItemRepository.new([ 
    	{name: "adsk", unit_price: "43215"},
        {name: "adsk", unit_price: "43215"},
        {name: "kjkk", unit_price: "43215"}
      ], "fake_sales_engine"
    )

    names = repo.find_all_by_name("adsk")
    names.each do |name|
      assert_equal ["adsk", "adsk"], names.map { |name| name.name }
    end

    names = repo.find_all_by_name("kjkk")
    names.each do |name|
      assert_equal ["kjkk"], names.map { |name| name.name }
    end

    names = repo.find_all_by_name("ggggggg")
    names.each do |name|
      assert_equal [], names.map { |name| name.name }
    end
  end

  def test_find_item_by_description
    repo = ItemRepository.new([
   	{description: "description1", unit_price: "43215"}, {description: "description2", unit_price: "43215"}, {description: "description3", unit_price: "43215"},
   	{description: "description2", unit_price: "43215"}
   	], "fake_sales_engine")
    items_description = repo.find_by_description("description1")
      assert_equal "description1", items_description.description
  end

  def test_find_all_by_description
    repo       = ItemRepository.new([ 
    	{description: "adsk", unit_price: "43215"},
        {description: "adsk", unit_price: "43215"},
        {description: "kjkk", unit_price: "43215"}
      ], "fake_sales_engine"
    )

    descriptions = repo.find_all_by_description("adsk")
    descriptions.each do |description|
      assert_equal ["adsk", "adsk"], descriptions.map { |description| description.description }
    end

    descriptions = repo.find_all_by_description("kjkk")
    descriptions.each do |description|
      assert_equal ["kjkk"], descriptions.map { |description| description.description }
    end

    descriptions = repo.find_all_by_description("ggggggg")
    descriptions.each do |description|
      assert_equal [], descriptions.map { |description| description.description }
    end
  end

  def test_find_item_by_unit_price
    repo = ItemRepository.new([
   	{unit_price: "43215"}, {unit_price: "43215"}, {unit_price: "2000"},
   	{unit_price: "43215"}
   	], "fake_sales_engine")
    items_unit_price = repo.find_by_unit_price(20.00)
      assert_equal 20.00, items_unit_price.unit_price
  end

  def test_find_all_by_unit_price
    repo       = ItemRepository.new([ 
    	{unit_price: "2000"},
        {unit_price:" 2000"},
        {unit_price: "3000"}
      ], "fake_sales_engine"
    )

    unit_prices = repo.find_all_by_unit_price(20.0)
    unit_prices.each do |unit_price|
      assert_equal [20.00, 20.00], unit_prices.map { |unit_price| unit_price.unit_price }
    end

    unit_prices = repo.find_all_by_unit_price(30.0)
    unit_prices.each do |unit_price|
      assert_equal [30.00], unit_prices.map { |unit_price| unit_price.unit_price }
    end

    unit_prices = repo.find_all_by_unit_price(999.9)
    unit_prices.each do |unit_price|
      assert_equal [], unit_prices.map { |unit_price| unit_price.unit_price }
    end
  end

   def test_find_item_by_merchant_id
    repo = ItemRepository.new([
   	{merchant_id: 20, unit_price: "43215"}, {merchant_id: 30, unit_price: "43215"}, {merchant_id: 40, unit_price: "43215"},
   	{merchant_id: 30, unit_price: "43215"}
   	], "fake_sales_engine")
    items_merchant_id = repo.find_by_merchant_id(20)
      assert_equal 20, items_merchant_id.merchant_id
  end

  def test_find_all_by_merchant_id
    repo       = ItemRepository.new([ 
    	{merchant_id: 2, unit_price: "43215"},
        {merchant_id: 2, unit_price: "43215"},
        {merchant_id: 3, unit_price: "43215"}
      ], "fake_sales_engine"
    )

    merchant_ids = repo.find_all_by_merchant_id(2)
    merchant_ids.each do |merchant_id|
      assert_equal [2, 2], merchant_ids.map { |merchant_id| merchant_id.merchant_id }
    end

    merchant_ids = repo.find_all_by_merchant_id(3)
    merchant_ids.each do |merchant_id|
      assert_equal [3], merchant_ids.map { |merchant_id| merchant_id.merchant_id }
    end

    merchant_ids = repo.find_all_by_merchant_id(9)
    merchant_ids.each do |merchant_id|
      assert_equal [], merchant_ids.map { |merchant_id| merchant_id.merchant_id }
    end
  end

  def test_find_item_by_created_at
    repo = ItemRepository.new([
   	{created_at: "20", unit_price: "43215"}, {created_at: "30", unit_price: "43215"}, {created_at: "40", unit_price: "43215"},
   	{created_at: "30", unit_price: "43215"}
   	], "fake_sales_engine")
    items_created_at = repo.find_by_created_at("20")
      assert_equal "20", items_created_at.created_at
  end

  def test_find_all_by_created_at
    repo       = ItemRepository.new([ 
    	{created_at: "string", unit_price: "43215"},
        {created_at: "string", unit_price: "43215"},
        {created_at: "other string", unit_price: "43215"}
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

  def test_find_item_by_updated_at
    repo = ItemRepository.new([
   	{updated_at: "20", unit_price: "43215"}, {updated_at: "30", unit_price: "43215"}, {updated_at: "40", unit_price: "43215"},
   	{updated_at: "30", unit_price: "43215"}
   	], "fake_sales_engine")
    items_updated_at = repo.find_by_updated_at("20")
      assert_equal "20", items_updated_at.updated_at
  end

  def test_find_all_by_updated_at
    repo       = ItemRepository.new([ 
    	{updated_at: "string", unit_price: "43215"},
        {updated_at: "string" ,unit_price: "43215"},
        {updated_at: "other string", unit_price: "43215"}
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

  def test_pass_item_id_up_to_sales_engine
    sales_engine = Minitest::Mock.new
    repo = ItemRepository.new([{id: 23, item_id: 231, unit_price: "43215"}], sales_engine)
    sales_engine.expect(:find_all_invoice_items_by_item_id, [], [231])
    repo.find_all_invoice_items_by_item_id(231)
    sales_engine.verify
  end

  def test_pass_merchant_id_up_to_sales_engine
    sales_engine = Minitest::Mock.new
    repo = ItemRepository.new([{id: 23, merchant_id: 231, unit_price: "43215"}], sales_engine)
    repo = ItemRepository.new([{id: 23, merchant_id: 231, unit_price: "43215"}], sales_engine)
    sales_engine.expect(:find_merchant_by_merchant_id, [], [231])
    repo.find_merchant_by_merchant_id(231)
    sales_engine.verify
  end

  def test_most_revenue
    #all items find successful merchant invoices and total revenue
    sales_engine = Minitest::Mock.new

    # invoice_item_repo = InvoiceItemRepository.new([
    #       {id: 4, invoice_id: 24, item_id: 451, unit_price: "4000", quantity: 1},
    #       {id: 3, invoice_id: 25, item_id: 451, unit_price: "4000", quantity: 1},
    #       {id: 1, invoice_id: 26, item_id: 35, unit_price: "5000", quantity: 1},
    #       {id: 2, invoice_id: 27, item_id: 450, unit_price: "6000", quantity: 1}], sales_engine)

    item_repo = ItemRepository.new([], sales_engine)
    items = [OpenStruct.new(total_revenue: 8000), OpenStruct.new(total_revenue: 6000)]

    item_repo.stub(:all, items) {
      top_items = item_repo.most_revenue(2)
      assert_equal [8000, 6000], top_items.map {|item| item.total_revenue}
    }

    # invoice_repo = InvoiceRepository.new([
    #     {id: 24},
    #     {id: 25},
    #     {id: 26},
    #     {id: 27}], sales_engine)

    # transaction_repo = TransactionRepository.new([
    #     {id: 37, result: "success", invoice_id: 24},
    #     {id: 36, result: "failed", invoice_id: 25},
    #     {id: 35, result: "success", invoice_id: 25},
    #     {id: 450, result: "failed", invoice_id: 26},
    #     {id: 451, result: "success", invoice_id: 27}], sales_engine)



  end


end