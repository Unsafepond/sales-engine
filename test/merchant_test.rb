require 'minitest/autorun'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_class
    assert Merchant
  end

  def test_it_can_pass_instances_up_to_item_repo
    repo = Minitest::Mock.new
    merchant = Merchant.new({ id: "23" }, repo)
    repo.expect(:find_all_items_by_merchant_id, [], [merchant.id])
    merchant.items
    repo.verify
  end

  def test_it_can_pass_instances_up_to_item_repo_for_invoices
    repo = Minitest::Mock.new
    merchant = Merchant.new({ id: "41" }, repo)
    repo.expect(:find_all_invoices_by_merchant_id, [], [merchant.id])
    merchant.invoices
    repo.verify
  end
end
