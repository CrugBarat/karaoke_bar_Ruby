require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/karaoke_bar.rb')
require_relative('../classes/operations.rb')
require_relative('../classes/customers.rb')
require_relative('../classes/rooms.rb')
require_relative('../classes/drinks.rb')
require_relative('../classes/food.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestKaraokeBar < MiniTest::Test

  def setup()
    @room1 = Rooms.new("Madonna Room", 25.00, @stock, 6, 10.00, @playlist)
    @room2 = Rooms.new("Nirvana Room", 25.00, @stock, 1, 10.00, @playlist)
    @rooms = [@room_2, @room_3]
    @customer1 = Customers.new("Audrey", 25, 38.00, 20, "Pillow Talk")
    @customer2 = Customers.new("Bea", 21, 5.00, 35, "Come on Eileen")
    @customer3 = Customers.new("Ally", 17, 15.00, 0, "Dancing Queen")
    @customer4 = Customers.new("Colin", 36, 115.00, 55, "Wonderwall")
    @karaoke_bar = KaraokeBar.new("The Sing Inn", 50.00, @stock, @rooms)
    @drink1 = Drinks.new("Tennents", :Lager, 8.00, 5)
    @food1 = Food.new("Burger", 6.00, 15)
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
    assert_equal(0, @room1.customer_count())
  end

  def test_can_add_customer_to_room()
    @room1.add_customer(@customer1)
    assert_equal(1, @room1.customer_count())
  end

  def test_can_remove_customer_from_room()
    @room1.add_customer(@customer1)
    @room1.add_customer(@customer2)
    @room1.remove_customer(@customer1)
    assert_equal(1, @room1.customer_count())
  end

  def test_can_empty_room()
    @room1.add_customer(@customer1)
    @room1.add_customer(@customer1)
    @room1.add_customer(@customer1)
    @room1.clear_room()
    assert_equal(0, @room1.customer_count())
  end

  def test_room_count()
    assert_equal(2, @karaoke_bar.room_count())
  end

  def test_add_new_room()
    @karaoke_bar.add_new_room(@room1)
    assert_equal(3, @karaoke_bar.room_count())
  end

  def test_customer_can_afford_drink__true()
    assert_equal(true, @karaoke_bar.customer_has_cash?(@customer1, @drink1))
  end

  def test_customer_can_afford_drink__false()
    assert_equal(false, @karaoke_bar.customer_has_cash?(@customer2, @drink1))
  end

  def test_customer_can_afford_food__true()
    assert_equal(true, @karaoke_bar.customer_has_cash?(@customer1, @food1))
  end

  def test_customer_can_afford_food__false()
    assert_equal(false, @karaoke_bar.customer_has_cash?(@customer2, @food1))
  end

  def test_customer_can_afford_room_fee__true()
    assert_equal(true, @karaoke_bar.customer_has_cash?(@customer1, @room1))
  end

  def test_customer_can_afford_room_fee__true()
    assert_equal(false, @karaoke_bar.customer_has_cash?(@customer2, @room1))
  end

  def test_room_capacity_full__false()
    @room2.add_customer(@customer1)
    @room2.add_customer(@customer2)
    assert_equal(false, @karaoke_bar.room_capacity_full?(@room1))
  end

  def test_room_capacity_full__true()
    @room2.add_customer(@customer1)
    @room2.add_customer(@customer2)
    assert_equal(true, @karaoke_bar.room_capacity_full?(@room2))
  end

  def test_customer_is_above_age__can_enter()
    assert_equal(true, @karaoke_bar.customer_is_above_age?(@customer2))
  end

  def test_customer_is_above_age__too_young()
    assert_equal(false, @karaoke_bar.customer_is_above_age?(@customer3))
  end

  def test_customer_too_drunk__true()
    assert_equal(true, @karaoke_bar.customer_too_drunk?(@customer4))
  end

  def test_customer_too_drunk_false()
    assert_equal(false, @karaoke_bar.customer_too_drunk?(@customer1))
  end

  def test_add_customer_to_room_with_conditions__success()
    @room1.add_customer(@customer1)
    @room1.add_customer(@customer1)
    @karaoke_bar.add_customer_to_room(@room1, @customer1)
    assert_equal(3, @room1.customer_count())
    assert_equal(28.00, @customer1.wallet())
    assert_equal(60.00, @karaoke_bar.till())
  end

  def test_add_customer_to_room_with_conditions__funds_fail()
    @room1.add_customer(@customer1)
    @room1.add_customer(@customer1)
    @karaoke_bar.add_customer_to_room(@room1, @customer2)
    assert_equal(2, @room1.customer_count())
    assert_equal(5.00, @customer2.wallet())
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_add_customer_to_room_with_conditions__age_fail()
    @room1.add_customer(@customer1)
    @room1.add_customer(@customer1)
    @room1.add_customer(@customer1)
    @karaoke_bar.add_customer_to_room(@room1, @customer3)
    assert_equal(3, @room1.customer_count())
    assert_equal(15.00, @customer3.wallet())
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_add_customer_to_room_with_conditions__capacity_fail()
    @room2.add_customer(@customer1)
    @karaoke_bar.add_customer_to_room(@room2, @customer1)
    assert_equal(1, @room2.customer_count())
    assert_equal(38.00, @customer1.wallet())
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_add_customer_to_room_with_conditions__drunkness_fail()
    @room1.add_customer(@customer1)
    @karaoke_bar.add_customer_to_room(@room1, @customer4)
    assert_equal(1, @room1.customer_count())
    assert_equal(115.00, @customer4.wallet())
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_serve_food_to_customer__success()
    @karaoke_bar.serve_food_to_customer(@customer1, @food1)
    assert_equal(32.00, @customer1.wallet())
    assert_equal(5, @customer1.drunkness())
    assert_equal(56.00, @karaoke_bar.till())
  end

  def test_serve_food_to_customer__funds_fail()
    @karaoke_bar.serve_food_to_customer(@customer2, @food1)
    assert_equal(5.00, @customer2.wallet())
    assert_equal(35, @customer2.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_serve_drink_to_customer__success()
    @karaoke_bar.serve_drink_to_customer(@customer1, @drink1)
    assert_equal(30.00, @customer1.wallet())
    assert_equal(25, @customer1.drunkness())
    assert_equal(58.00, @karaoke_bar.till())
  end

  def test_serve_drink_to_customer__age_fail()
    @karaoke_bar.serve_drink_to_customer(@customer3, @drink1)
    assert_equal(15.00, @customer3.wallet())
    assert_equal(0, @customer3.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_serve_drink_to_customer__funds_fail()
    @karaoke_bar.serve_drink_to_customer(@customer2, @drink1)
    assert_equal(5.00, @customer2.wallet())
    assert_equal(35, @customer2.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_serve_drink_to_customer__drunkness_fail()
    @karaoke_bar.serve_drink_to_customer(@customer4, @drink1)
    assert_equal(115.00, @customer4.wallet())
    assert_equal(55, @customer4.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
  end

end
