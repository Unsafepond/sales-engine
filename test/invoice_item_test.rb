require 'minitest/autorun'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_class
    assert InvoiceItem
  end

  def test_it_can_pass_invoice_id_instances_up_to_invoice_repo
    repo = Minitest::Mock.new
    invoice_item = InvoiceItem.new({ id: "23", invoice_id: 45 }, repo)
    repo.expect(:find_invoice_by_invoice_id, [], [invoice_item.invoice_id])
    invoice_item.invoice
    repo.verify
  end

  def test_it_can_pass_item_id_instances_up_to_invoice_repo
    repo = Minitest::Mock.new
    invoice_item = InvoiceItem.new({ id: "23", item_id: 45 }, repo)
    repo.expect(:find_item_by_item_id, [], [invoice_item.item_id])
    invoice_item.item
    repo.verify
  end

end