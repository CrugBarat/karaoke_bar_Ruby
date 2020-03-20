require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/drinks.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestDrinks < MiniTest::Test

  def setup()
    @drink1 = Drinks.new("Tennents", :Lager, 4.00, 5)
  end

  def test_get_name()
    assert_equal("Tennents", @drink1.name())
  end

  def test_get_type()
    assert_equal(:Lager, @drink1.type())
  end

  def test_get_price()
    assert_equal(4.00, @drink1.price())
  end

  def test_get_alcohol_content()
    assert_equal(5, @drink1.alcohol_content())
  end

  def test_set_name()
    @drink1.name = "Jack Daniels"
    assert_equal("Jack Daniels", @drink1.name())
  end

  def test_set_price()
    @drink1.price = 6.50
    assert_equal(6.50, @drink1.price())
  end

  def test_set_type()
    @drink1.type = :Dark_Rum
    assert_equal(:Dark_Rum, @drink1.type())
  end

  def test_set_alcohol_content()
    @drink1.alcohol_content = 35
    assert_equal(35, @drink1.alcohol_content())
  end

end
