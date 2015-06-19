require 'minitest/autorun'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_class
    assert Customer
  end

end
