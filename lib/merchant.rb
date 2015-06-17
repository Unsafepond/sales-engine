require_relative "merchant_repository"

class Merchant
  attr_reader :merchant_repo, :id, :name, :created_at, :updated_at

  def initialize(row, merchant_repo)
    @merchant_repo = merchant_repo
    @id = row[:id].to_i
    @name = row[:name].capitalize
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end


end

