require 'minitest/autorun'
require '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_class
    assert SalesEngine
  end

  def test_startup_reads_csv
    data_directory = File.expand_path 'fixtures', __dir__
    se = SalesEngine.new(data_directory)
    se.startup
    repo = se.merchant_repository

    names = repo.find_all_by_name("Schroeder-Jerde")
    names.each do |name|
      assert_equal "Schroeder-Jerde", name.name
    end
  end

end







































