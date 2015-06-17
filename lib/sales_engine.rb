require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require 'pry'
# etc
#  read files for each type of supplied csv
#  send the raw data to respective repository
#  respond to methods in test harness that accesses data from any data point
class SalesEngine
  def initialize(data_dir)
    @data_dir = data_dir
  end

  attr_accessor :merchant_repository

  def startup
    hashes = CSV.read "#{@data_dir}/merchants.csv", headers: true, header_converters: :symbol
    @merchant_repository      = MerchantRepository.new(hashes)


  end
end

