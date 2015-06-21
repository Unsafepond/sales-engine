require 'minitest/autorun'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test
  def test_class
    assert Item
  end

  def test_big_decimal
    item = Item.new({ id: "23", unit_price: "43215"}, "self")
    assert_equal 432.15, item.unit_price
  end

  def test_it_can_pass_instances_up_to_item_repo
    repo = Minitest::Mock.new
    item = Item.new({ id: "23", unit_price: "4321"}, repo)
    repo.expect(:find_all_invoice_items_by_item_id, [], [item.id])
    item.invoice_items
    repo.verify
  end

  def test_it_can_pass_merchant_id_instances_up_to_item_repo
    repo = Minitest::Mock.new
    item = Item.new({ id: "23", merchant_id: 45, unit_price: "4321" }, repo)
    repo.expect(:find_merchant_by_merchant_id, [], [item.merchant_id])
    item.merchant
    repo.verify
  end
end
