require 'minitest/autorun'
require '../lib/item_repository'
require '../lib/sales_engine'
require 'pry'
# id,name,description,unit_price,merchant_id,
# created_at,updated_at
class ItemRepositoryTest < Minitest::Test

def test_class
    assert ItemRepository
  end

  def test_find_all_items
    repo = ItemRepository.new([
    	{id: 1}, {id: 2}, {id: 3},
    	{id: 2}
    	])
    assert_equal 4, repo.all.count
end

 def test_find_random_items
    repo = ItemRepository.new([
    	{id: 1}, {id: 2}, {id: 3},
    	{id: 2}
    	])
    item_permutations = repo.all.permutation.to_a
    assert item_permutations.include?(repo.random)
  end

  def test_find_item_by_id
    repo = ItemRepository.new([
    	{id: 1}, {id: 2}, {id: 3},
    	{id: 2}
    	])
    items_id = repo.find_by_id(1)
      assert_equal 1, items_id.id
  end

  def test_find_all_by_id
    repo       = ItemRepository.new([ 
    	{id: 1},
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

def test_find_item_by_name
    repo = ItemRepository.new([
   	{name: "name1"}, {name: "name2"}, {name: "name3"},
   	{name: "name2"}
   	])
    items_name = repo.find_by_name("name1")
      assert_equal "name1", items_name.name
  end

  def test_find_all_by_name
    repo       = ItemRepository.new([ 
    	{name: "adsk"},
        {name: "adsk"},
        {name: "kjkk"}
      ]
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
   	{description: "description1"}, {description: "description2"}, {description: "description3"},
   	{description: "description2"}
   	])
    items_description = repo.find_by_description("description1")
      assert_equal "description1", items_description.description
  end

  def test_find_all_by_description
    repo       = ItemRepository.new([ 
    	{description: "adsk"},
        {description: "adsk"},
        {description: "kjkk"}
      ]
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
   	{unit_price: 20.0}, {unit_price: 30.0}, {unit_price: 40.0},
   	{unit_price: 30.0}
   	])
    items_unit_price = repo.find_by_unit_price(20.0)
      assert_equal 20.0, items_unit_price.unit_price
  end

  def test_find_all_by_unit_price
    repo       = ItemRepository.new([ 
    	{unit_price: 20.0},
        {unit_price: 20.0},
        {unit_price: 30.0}
      ]
    )

    unit_prices = repo.find_all_by_unit_price(20.0)
    unit_prices.each do |unit_price|
      assert_equal [20.0, 20.0], unit_prices.map { |unit_price| unit_price.unit_price }
    end

    unit_prices = repo.find_all_by_unit_price(30.0)
    unit_prices.each do |unit_price|
      assert_equal [30.0], unit_prices.map { |unit_price| unit_price.unit_price }
    end

    unit_prices = repo.find_all_by_unit_price(999.9)
    unit_prices.each do |unit_price|
      assert_equal [], unit_prices.map { |unit_price| unit_price.unit_price }
    end
  end

   def test_find_item_by_merchant_id
    repo = ItemRepository.new([
   	{merchant_id: 20}, {merchant_id: 30}, {merchant_id: 40},
   	{merchant_id: 30}
   	])
    items_merchant_id = repo.find_by_merchant_id(20)
      assert_equal 20, items_merchant_id.merchant_id
  end

  def test_find_all_by_merchant_id
    repo       = ItemRepository.new([ 
    	{merchant_id: 2},
        {merchant_id: 2},
        {merchant_id: 3}
      ]
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
   	{created_at: "20"}, {created_at: "30"}, {created_at: "40"},
   	{created_at: "30"}
   	])
    items_created_at = repo.find_by_created_at("20")
      assert_equal "20", items_created_at.created_at
  end

  def test_find_all_by_created_at
    repo       = ItemRepository.new([ 
    	{created_at: "string"},
        {created_at: "string"},
        {created_at: "other string"}
      ]
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
   	{updated_at: "20"}, {updated_at: "30"}, {updated_at: "40"},
   	{updated_at: "30"}
   	])
    items_updated_at = repo.find_by_updated_at("20")
      assert_equal "20", items_updated_at.updated_at
  end

  def test_find_all_by_updated_at
    repo       = ItemRepository.new([ 
    	{updated_at: "string"},
        {updated_at: "string"},
        {updated_at: "other string"}
      ]
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


end