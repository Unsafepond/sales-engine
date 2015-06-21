require 'minitest/autorun'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def test_class
    assert Invoice
  end

  def test_it_can_pass_merchant_instances_up_to_item_repo
    repo = Minitest::Mock.new
    invoice = Invoice.new({ id: "23", merchant_id: "231" }, repo)
    repo.expect(:find_invoice_merchant_with_merchant_id, [], [invoice.merchant_id])
    invoice.merchant
    repo.verify
  end

  def test_it_can_pass_customer_instances_up_to_item_repo
    repo = Minitest::Mock.new
    invoice = Invoice.new({ id: "23", customer_id: "231" }, repo)
    repo.expect(:find_invoice_customer_with_customer_id, [], [invoice.customer_id])
    invoice.customer
    repo.verify
  end
end