require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/karaoke_bar.rb')
require_relative('../classes/operations.rb')
require_relative('../classes/customers.rb')
require_relative('../classes/rooms.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestKaraokeBar < MiniTest::Test

  def setup()
    @room_1 = Rooms.new("Madonna Room", 25.00, @stock, 6, 10.00, @playlist)
    @rooms = [@room_2, @room_3]
    @customer1 = Customers.new("Audrey", 25, 38.00, 20, "Pillow Talk")
    @customer2 = Customers.new("Bea", 21, 20.00, 35, "Come on Eileen")
    @karaoke_bar = KaraokeBar.new("The Sing Inn", 50.00, @stock, @rooms)
  end

  def test_get_name()
    assert_equal("The Sing Inn", @karaoke_bar.name())
  end

  def test_get_till()
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_get_rooms()
    assert_equal(@rooms, @karaoke_bar.rooms())
  end

  def test_set_till()
    @karaoke_bar.till = 100.00
    assert_equal(100.00, @karaoke_bar.till())
  end

  def test_can_add_money_to_till
    @karaoke_bar.add_money_to_till(15.00)
    assert_equal(65.00, @karaoke_bar.till)
  end

  def test_can_remove_money_from_till
    @karaoke_bar.remove_money_from_till(15.00)
    assert_equal(35.00, @karaoke_bar.till)
  end

  def test_customer_bar_count__empty()
    assert_equal(0, @karaoke_bar.customer_count())
  end

  def test_can_add_customer_to_bar()
    @karaoke_bar.add_customer(@customer1)
    assert_equal(1, @karaoke_bar.customer_count())
  end

  def test_can_remove_customer_from_bar()
    @karaoke_bar.add_customer(@customer1)
    @karaoke_bar.add_customer(@customer2)
    @karaoke_bar.remove_customer(@customer1)
    assert_equal(1, @karaoke_bar.customer_count())
  end

  def test_can_empty_bar()
    @karaoke_bar.add_customer(@customer1)
    @karaoke_bar.add_customer(@customer1)
    @karaoke_bar.add_customer(@customer1)
    @karaoke_bar.clear_room()
    assert_equal(0, @karaoke_bar.customer_count())
  end

  def test_customer_room_count__empty()
    assert_equal(0, @room_1.customer_count())
  end

  def test_can_add_customer_to_room()
    @room_1.add_customer(@customer1)
    assert_equal(1, @room_1.customer_count())
  end

  def test_can_remove_customer_from_room()
    @room_1.add_customer(@customer1)
    @room_1.add_customer(@customer2)
    @room_1.remove_customer(@customer1)
    assert_equal(1, @room_1.customer_count())
  end

  def test_can_empty_room()
    @room_1.add_customer(@customer1)
    @room_1.add_customer(@customer1)
    @room_1.add_customer(@customer1)
    @room_1.clear_room()
    assert_equal(0, @room_1.customer_count())
  end

  def test_room_count()
    assert_equal(2, @karaoke_bar.room_count())
  end

  def test_add_new_room()
    @karaoke_bar.add_new_room(@room_1)
    assert_equal(3, @karaoke_bar.room_count())
  end

end
