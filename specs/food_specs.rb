require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/food.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestFood < MiniTest::Test

  def setup()
    @food1 = Food.new("Burger", 6.00, 15)
  end

  def test_get_name()
    assert_equal("Burger", @food1.name())
  end

  def test_get_price()
    assert_equal(6.00, @food1.price())
  end

  def test_get_rejuv_level()
    assert_equal(15, @food1.rejuv_level())
  end

  def test_set_name()
    @food1.name = "Nachos"
    assert_equal("Nachos", @food1.name())
  end

  def test_set_price()
    @food1.price = 4.95
    assert_equal(4.95, @food1.price())
  end

  def test_set_rejuv_level()
    @food1.rejuv_level = 35
    assert_equal(35, @food1.rejuv_level())
  end

end
