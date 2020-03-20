require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/rooms.rb')
require_relative('../classes/customers.rb')
require_relative('../classes/operations.rb')
require_relative('../classes/songs.rb')
require_relative('../classes/food.rb')
require_relative('../classes/drinks.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestRooms < MiniTest::Test

  def setup()
    @song1 = Songs.new("Oh L'Amour", "Erasure", @lyrics)
    @song2 = Songs.new("Blue Monday", "New Order", @lyrics)
    @song3 = Songs.new("A Little Respect", "Erasure", @lyrics)
    @playlist = [@song1, @song2]
    @room1 = Rooms.new("Elvis Room", 30.00, @stock, 8, 10.00, @playlist)
    @customer1 = Customers.new("Frank", 35, 45.00, 5, "A Little Respect")
    @customer2 = Customers.new("Bea", 21, 5.00, 35, "Come on Eileen")
    @customer3 = Customers.new("Ally", 17, 15.00, 0, "Dancing Queen")
    @customer4 = Customers.new("Colin", 36, 115.00, 55, "Wonderwall")
    @drink1 = Drinks.new("Tennents", :Lager, 8.00, 5)
    @food1 = Food.new("Burger", 6.00, 15)
  end

  def test_get_name()
    assert_equal("Elvis Room", @room1.name())
  end

  def test_get_till()
    assert_equal(30.00, @room1.till())
  end

  def test_get_capacity()
    assert_equal(8, @room1.capacity())
  end

  def test_get_price()
    assert_equal(10.00, @room1.price())
  end

  def test_get_playlist()
    assert_equal(@playlist, @room1.playlist())
  end

  def test_set_till()
    @room1.till = 40.00
    assert_equal(40.00, @room1.till())
  end

  def test_set_capacity()
    @room1.capacity = 12
    assert_equal(12, @room1.capacity())
  end

  def test_set_price()
    @room1.price = 8.00
    assert_equal(8.00, @room1.price())
  end

  def test_can_add_money_to_till
    @room1.add_money_to_till(15.00)
    assert_equal(45.00, @room1.till)
  end

  def test_can_remove_money_from_till
    @room1.remove_money_from_till(10.00)
    assert_equal(20.00, @room1.till)
  end

  def test_playlist_count()
    assert_equal(2, @room1.playlist_count())
  end

  def test_clear_playlist()
    @room1.clear_playlist()
    assert_equal(0, @room1.playlist_count())
  end

  def test_add_song_to_playlist()
    @room1.add_song_to_playlist(@song3)
    assert_equal(3, @room1.playlist_count())
  end

  def test_customer_can_afford_drink__true()
    assert_equal(true, @room1.customer_has_cash?(@customer1, @drink1))
  end

  def test_customer_can_afford_drink__false()
    assert_equal(false, @room1.customer_has_cash?(@customer2, @drink1))
  end

  def test_customer_can_afford_food__true()
    assert_equal(true, @room1.customer_has_cash?(@customer1, @food1))
  end

  def test_customer_can_afford_food__false()
    assert_equal(false, @room1.customer_has_cash?(@customer2, @food1))
  end

  def test_customer_is_above_age__can_enter()
    assert_equal(true, @room1.customer_is_above_age?(@customer2))
  end

  def test_customer_is_above_age__too_young()
    assert_equal(false, @room1.customer_is_above_age?(@customer3))
  end

  def test_customer_too_drunk__true()
    assert_equal(true, @room1.customer_too_drunk?(@customer4))
  end

  def test_customer_too_drunk_false()
    assert_equal(false, @room1.customer_too_drunk?(@customer1))
  end

end
