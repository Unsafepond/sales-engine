require 'minitest/autorun'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_class
    assert MerchantRepository.new
  end
end