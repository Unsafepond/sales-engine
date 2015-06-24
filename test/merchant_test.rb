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
  def test_it_has_revenue
    invoice = Minitest::Mock.new
    invoice.expect(:successful?, true, [])
    invoice.expect(:revenue, 50, [])

    repo = Minitest::Mock.new
    merchant = Merchant.new({ id: "41" }, repo)
    repo.expect(:find_all_invoices_by_merchant_id, [invoice], [merchant.id])

    assert_equal 50, merchant.revenue
  end
  def test_it_can_get_revenue_by_date
    invoice_2 = Minitest::Mock.new
    invoice_2.expect(:successful?, true, [])
    invoice_2.expect(:created_at, Date.parse("2012-03-27 14:53:59 UTC"), [])
    invoice_2.expect(:revenue, 30, [])

    invoice_1 = Minitest::Mock.new
    invoice_1.expect(:successful?, true, [])
    invoice_1.expect(:created_at, Date.parse("2012-03-28 14:53:59 UTC"), [])
    invoice_1.expect(:revenue, 50, [])

    repo = Minitest::Mock.new

    merchant = Merchant.new({ id: "41" }, repo)

    repo.expect(:find_all_invoices_by_merchant_id, [invoice_1, invoice_2], [merchant.id])

    assert_equal 30, merchant.revenue(Date.parse("2012-03-27"))

  end
end
