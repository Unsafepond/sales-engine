require 'minitest/autorun'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_class
    assert Merchant.new
  end

end