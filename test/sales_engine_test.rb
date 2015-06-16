require 'minitest/autorun'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_class
    assert SalesEngine.new
  end

end