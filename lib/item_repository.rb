require_relative 'sales_engine'
require_relative 'items'

class ItemRepository
	attr_reader :all
	def initialize(hashes)
    	@all = hashes.map { |hash| Item.new(hash.to_hash, self)}
  	end

 	def random
    	@all.shuffle
 	end

  	def find_by_id(id)
    	@all.find { |item| item.id == id }
  	end

  	def find_all_by_id(id)
    	@all.select { |item| item.id == id }
  	end

  	def find_by_name(name)
    	@all.find { |item| item.name == name }
  	end

  	def find_all_by_name(name)
    	@all.select { |item| item.name == name }
  	end

  	def find_by_description(description)
    	@all.find { |item| item.description == description }
  	end

  	def find_all_by_description(description)
    	@all.select { |item| item.description == description }
  	end

  	def find_by_unit_price(unit_price)
    	@all.find { |item| item.unit_price == unit_price }
  	end

  	def find_all_by_unit_price(unit_price)
    	@all.select { |item| item.unit_price == unit_price }
  	end

  	def find_by_merchant_id(merchant_id)
    	@all.find { |item| item.merchant_id == merchant_id }
  	end

  	def find_all_by_merchant_id(merchant_id)
    	@all.select { |item| item.merchant_id == merchant_id }
  	end

  	def find_by_created_at(created_at)
    	@all.find { |item| item.created_at == created_at }
  	end

  	def find_all_by_created_at(created_at)
    	@all.select { |item| item.created_at == created_at }
  	end

  	def find_by_updated_at(updated_at)
    	@all.find { |item| item.updated_at == updated_at }
  	end

  	def find_all_by_updated_at(updated_at)
    	@all.select { |item| item.updated_at == updated_at }
  	end

end