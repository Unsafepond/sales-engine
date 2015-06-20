require 'minitest/autorun'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def test_class
    assert Transaction
  end

  def test_it_can_pass_instances_up_to_invoice_repo
    repo = Minitest::Mock.new
    transaction = Transaction.new({ id: "15", invoice_id: "231" }, repo)
    repo.expect(:find_invoice_by_invoice_id, [], [transaction.invoice_id])
    transaction.invoice
    repo.verify
  end
end
