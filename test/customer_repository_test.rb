require 'minitest/autorun'
require './lib/customer_repository'
require './lib/sales_engine'
require 'pry'

class CustomerRepositoryTest < Minitest::Test

  def test_class
    assert CustomerRepository
  end

  def test_find_all_customers
    data = [{id: 1, name: "Sylvester"},
      {id: 1, name: "Mary"},
      {id: 3, name: "Sylvester"}
    ]

    repo = CustomerRepository.new(data, 'sales engine self instance')

    assert_equal 3, repo.all.count

  end

  def test_find_random_customers
    repo       = CustomerRepository.new(
      [{id: 1, first_name: "Sylvester"}
      ], 'sales engine self instance'
    )
    assert_equal 1, repo.random.id

  end

  def test_find_customer_by_id
    repo       = CustomerRepository.new(
      [{id: 1, name: "Mike", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, name: "Jerrod", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, name: "Mike", created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )

    ids = repo.find_by_id(2)
    assert_equal 2, ids.id

  end

  def test_find_customer_by_first_name
    repo       = CustomerRepository.new(
      [{id: 1, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, first_name: "Jerrod", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )
    names = repo.find_by_first_name("Jerrod")
    assert_equal "Jerrod", names.first_name
  end

  def test_find_customer_by_last_name
    repo       = CustomerRepository.new(
      [{id: 1, last_name: "Dorrance", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, last_name: "Pond", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, last_name: "Dorrance", created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )
    names = repo.find_by_last_name("Pond")
    assert_equal "Pond", names.last_name
  end

  def test_find_customer_by_created_at
    repo       = CustomerRepository.new(
      [{id: 1, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, first_name: "Jerrod", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )

    created_at = repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", created_at.created_at

  end
  def test_find_customer_by_updated_at
    repo       = CustomerRepository.new(
      [{id: 1, first_name: "Mike", updated_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, first_name: "Jerrod", updated_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, first_name: "Mike", updated_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )

    updated_at = repo.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", updated_at.updated_at

  end

  def test_find_all_by_id
    repo       = CustomerRepository.new(
      [{id: 1, first_name: "Sylvester"},
        {id: 1, first_name: "Mary"},
        {id: 3, first_name: "Sylvester"}
      ], 'sales engine self instance'
    )

    ids = repo.find_all_by_id("1")
    ids.each do |id|
      assert_equal [1,2], ids.map { |id| id.id }
    end

    ids = repo.find_all_by_id("3")
    ids.each do |id|
      assert_equal [3], ids.map { |id| id.id }
    end

    ids = repo.find_all_by_id("4")
    ids.each do |id|
      assert_equal [], ids.map { |id| id.id }
    end
  end

  def test_find_all_by_first_name
    repo       = CustomerRepository.new(
      [{id: 1, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, first_name: "Jerrod", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )

    first_names = repo.find_all_by_first_name("Mike")
    first_names.each do |first_name|
      assert_equal 2, first_names.map { |first_name| first_name.first_name }.count
    end

    first_names = repo.find_all_by_first_name("Jerrod")
    first_names.each do |first_name|
      assert_equal ["Jerrod"], first_names.map { |first_name| first_name.first_name }
    end

    first_names = repo.find_all_by_first_name("Tim")
    first_names.each do |first_name|
      assert_equal [], first_names.map { |first_name| first_name.first_name }
    end
  end

  def test_find_all_by_last_name
    repo       = CustomerRepository.new(
      [{id: 1, last_name: "Dorrance", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, last_name: "Pond", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, last_name: "Dorrance", created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )

    last_names = repo.find_all_by_last_name("Mike")
    last_names.each do |last_name|
      assert_equal 2, last_names.map { |last_name| last_name.last_name }.count
    end

    last_names = repo.find_all_by_last_name("Jerrod")
    last_names.each do |last_name|
      assert_equal ["Jerrod"], last_names.map { |last_name| last_name.last_name }
    end

    last_names = repo.find_all_by_last_name("Tim")
    last_names.each do |last_name|
      assert_equal [], last_names.map { |last_name| last_name.last_name }
    end
  end

  def test_find_all_by_created_at
    repo       = CustomerRepository.new(
      [{id: 1, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, first_name: "Jerrod", created_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, first_name: "Mike", created_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )

    created_ats = repo.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    created_ats.each do |created_at|
      assert_equal 2, created_ats.map { |created_at| created_at.created_at }.count
    end

    created_ats = repo.find_all_by_created_at("Jerrod")
    created_ats.each do |created_at|
      assert_equal ["Jerrod"], created_ats.map { |created_at| created_at.created_at }
    end

    created_ats = repo.find_all_by_created_at("Tim")
    created_ats.each do |created_at|
      assert_equal [], created_ats.map { |created_at| created_at.created_at }
    end
  end

  def test_find_all_by_updated_at
    repo       = CustomerRepository.new(
      [{id: 1, first_first_name: "Mike", updated_at: "2012-03-27 14:53:59 UTC"},
        {id: 2, first_first_name: "Jerrod", updated_at: "1996-08-27 14:53:59 UTC"},
        {id: 3, first_first_name: "Mike", updated_at: "2012-03-27 14:53:59 UTC"}
      ], "fake sales egine"
    )

    updated_ats = repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    updated_ats.each do |updated_at|
      assert_equal 2, updated_ats.map { |updated_at| updated_at.updated_at }.count
    end

    updated_ats = repo.find_all_by_updated_at("Jerrod")
    updated_ats.each do |updated_at|
      assert_equal ["Jerrod"], updated_ats.map { |updated_at| updated_at.updated_at }
    end

    updated_ats = repo.find_all_by_updated_at("Tim")
    updated_ats.each do |updated_at|
      assert_equal [], updated_ats.map { |updated_at| updated_at.updated_at }
    end
  end

  def test_pass_customer_id_up_to_sales_engine
    sales_engine = Minitest::Mock.new
    repo = CustomerRepository.new([{id: 15}], sales_engine)
    sales_engine.expect(:find_all_invoices_by_customer_id, [], [15])
    repo.find_all_invoices_by_customer_id(15)
    sales_engine.verify
  end


end
