require 'minitest/autorun'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_class
    assert Customer
  end

  def test_it_can_pass_instances_up_to_invoice_repo
    repo = Minitest::Mock.new
    customer = Customer.new({ id: "15" }, repo)
    repo.expect(:find_all_invoices_by_customer_id, [], [customer.id])
    customer.invoices
    repo.verify
  end
end
