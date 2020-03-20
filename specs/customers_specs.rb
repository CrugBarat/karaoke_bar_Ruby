require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/customers.rb')
require_relative('../classes/drinks.rb')
require_relative('../classes/food.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestCustomers < MiniTest::Test

  def setup()
    @customer1 = Customers.new("Frank", 35, 45.00, 5, "A Little Respect")
    @drink1 = Drinks.new("Tennents", :Lager, 4.00, 5)
    @food1 = Food.new("Burger", 6.00, 15)
  end

  def test_get_name()
    assert_equal("Frank", @customer1.name())
  end

  def test_get_age()
    assert_equal(35, @customer1.age())
  end

  def test_get_wallet()
    assert_equal(45.00, @customer1.wallet())
  end

  def test_get_drunkness()
    assert_equal(5, @customer1.drunkness())
  end

  def test_get_fav_song()
    assert_equal("A Little Respect", @customer1.fav_song())
  end

  def test_set_name()
    @customer1.name = "Albert"
    assert_equal("Albert", @customer1.name())
  end

  def test_set_age()
    @customer1.age = 27
    assert_equal(27, @customer1.age())
  end

  def test_set_wallet()
    @customer1.wallet = 63.00
    assert_equal(63.00, @customer1.wallet())
  end

  def test_set_drunkness()
    @customer1.drunkness = 55
    assert_equal(55, @customer1.drunkness())
  end

  def test_get_fav_song()
    @customer1.fav_song = "Blue Savannah"
    assert_equal("Blue Savannah", @customer1.fav_song())
  end

  def test_customer_can_pay()
    @customer1.pay(6.00)
    assert_equal(39.00, @customer1.wallet())
  end

  def test_customer_can_consume_drink()
    @customer1.consume_drink(@drink1)
    assert_equal(10, @customer1.drunkness())
  end

  def test_customer_can_consume_food()
    @customer1.consume_food(@food1)
    assert_equal(-10, @customer1.drunkness())
  end

  def test_customer_can_cheers()
    assert_equal("Woohoo!", @customer1.cheers())
  end

end
