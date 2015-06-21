require 'minitest/autorun'
require './lib/item'

class ItemTest < Minitest::Test
  def test_class
    assert Item
  end

  def test_it_can_pass_instances_up_to_item_repo
    repo = Minitest::Mock.new
    item = Item.new({ id: "23" }, repo)
    repo.expect(:find_all_invoice_items_by_item_id, [], [item.id])
    item.invoice_items
    repo.verify
  end
end
