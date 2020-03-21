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
    @room1 = Rooms.new("Madonna Room", 25.00, 6, 10.00, @playlist)
    @room2 = Rooms.new("Nirvana Room", 25.00, 1, 10.00, @playlist)
    @rooms = [@room_2, @room_3]
    @customer1 = Customers.new("Audrey", 25, 38.00, 20, "Pillow Talk")
    @customer2 = Customers.new("Bea", 21, 5.00, 35, "Come on Eileen")
    @customer3 = Customers.new("Ally", 17, 15.00, 0, "Dancing Queen")
    @customer4 = Customers.new("Colin", 36, 115.00, 55, "Wonderwall")
    @customer5 = Customers.new("Ricky", 37, 50.00, 15, "Supersonic")
    @karaoke_bar = KaraokeBar.new("The Sing Inn", 50.00, @rooms, 5.00)
    @drink1 = Drinks.new("Tennents", :Lager, 8.00, 5)
    @food1 = Food.new("Burger", 6.00, 15)
  end

  def test_get_name()
    assert_equal("The Sing Inn", @karaoke_bar.name())
  end

  def test_get_till()
    assert_equal(50.00, @karaoke_bar.till())
  end

  def test_get_stock()
    assert_equal({}, @karaoke_bar.stock())
  end

  def test_get_rooms()
    assert_equal(@rooms, @karaoke_bar.rooms())
  end

  def test_get_price()
    assert_equal(5.00, @karaoke_bar.price())
  end

  def test_set_till()
    @karaoke_bar.till = 100.00
    assert_equal(100.00, @karaoke_bar.till())
  end

  def test_set_price()
    @karaoke_bar.price = 10.00
    assert_equal(10.00, @karaoke_bar.price())
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
    assert_equal(35.00, @room1.till())
    assert_equal(10.00, @room1.customer_spending())
  end

  def test_add_customer_to_bar_with_conditions__success()
    @karaoke_bar.add_customer(@customer1)
    @karaoke_bar.add_customer(@customer1)
    @karaoke_bar.add_customer_to_room(@karaoke_bar, @customer1)
    assert_equal(3, @karaoke_bar.customer_count())
    assert_equal(33.00, @customer1.wallet())
    assert_equal(55.00, @karaoke_bar.till())
    assert_equal(5.00, @karaoke_bar.customer_spending())
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

  def test_get_stock_level_drink__nil()
    result = @karaoke_bar.stock_level(@drink1)
    assert_nil(nil, result)
  end

  def test_get_stock_level_food__nil()
    result = @karaoke_bar.stock_level(@food1)
    assert_nil(nil, result)
  end

  def test_can_add_drink_to_stock()
    assert_equal(1, @karaoke_bar.add_item(@drink1))
  end

  def test_can_add_multiple_drinks_to_stock()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@drink1)
    result = @karaoke_bar.stock_level(@drink1)
    assert_equal(3, result)
  end

  def test_can_add_food_to_stock()
    assert_equal(1, @karaoke_bar.add_item(@food1))
  end

  def test_can_add_multiple_food_to_stock()
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@food1)
    result = @karaoke_bar.stock_level(@food1)
    assert_equal(3, result)
  end

  def test_get_stock_value__nil()
    assert_nil(nil, @karaoke_bar.stock_value())
  end

  def test_get_stock_value()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    assert_equal(14.00, @karaoke_bar.stock_value())
  end

  def test_get_stock_value_by_item()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    assert_equal(24.00, @karaoke_bar.stock_value_by_item(@drink1))
  end

  def test_get_stock_value_by_item()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    assert_equal(18.00, @karaoke_bar.stock_value_by_item(@food1))
  end

  def test_serve_food_to_customer__success()
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.serve_food_to_customer(@customer1, @food1)
    assert_equal(32.00, @customer1.wallet())
    assert_equal(5, @customer1.drunkness())
    assert_equal(56.00, @karaoke_bar.till())
    assert_equal(1, @karaoke_bar.stock_level(@food1))
  end

  def test_serve_food_to_customer__funds_fail()
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.serve_food_to_customer(@customer2, @food1)
    assert_equal(5.00, @customer2.wallet())
    assert_equal(35, @customer2.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
    assert_equal(2, @karaoke_bar.stock_level(@food1))
  end

  def test_serve_food_to_customer__stock_fail()
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.serve_food_to_customer(@customer5, @food1)
    @karaoke_bar.serve_food_to_customer(@customer1, @food1)
    assert_equal(38.00, @customer1.wallet())
    assert_equal(20, @customer1.drunkness())
    assert_equal(56.00, @karaoke_bar.till())
    assert_equal(0, @karaoke_bar.stock_level(@food1))
  end

  def test_serve_drink_to_customer__success()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.serve_drink_to_customer(@customer1, @drink1)
    assert_equal(30.00, @customer1.wallet())
    assert_equal(25, @customer1.drunkness())
    assert_equal(58.00, @karaoke_bar.till())
    assert_equal(1, @karaoke_bar.stock_level(@drink1))
  end

  def test_serve_drink_to_customer__age_fail()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.serve_drink_to_customer(@customer3, @drink1)
    assert_equal(15.00, @customer3.wallet())
    assert_equal(0, @customer3.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
    assert_equal(2, @karaoke_bar.stock_level(@drink1))
  end

  def test_serve_drink_to_customer__funds_fail()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.serve_drink_to_customer(@customer2, @drink1)
    assert_equal(5.00, @customer2.wallet())
    assert_equal(35, @customer2.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
    assert_equal(2, @karaoke_bar.stock_level(@drink1))
  end

  def test_serve_drink_to_customer__stock_fail()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.serve_drink_to_customer(@customer5, @drink1)
    @karaoke_bar.serve_drink_to_customer(@customer1, @drink1)
    assert_equal(38.00, @customer1.wallet())
    assert_equal(20, @customer1.drunkness())
    assert_equal(58.00, @karaoke_bar.till())
    assert_equal(0, @karaoke_bar.stock_level(@drink1))
  end

  def test_serve_drink_to_customer__drunkness_fail()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.serve_drink_to_customer(@customer4, @drink1)
    assert_equal(115.00, @customer4.wallet())
    assert_equal(55, @customer4.drunkness())
    assert_equal(50.00, @karaoke_bar.till())
    assert_equal(1, @karaoke_bar.stock_level(@drink1))
  end

  def test_customer_spending_starts_zero()
    assert_equal(0.00, @karaoke_bar.customer_spending())
  end

  def test_customer_spending_increases_with_food_purchase()
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.serve_food_to_customer(@customer1, @food1)
    assert_equal(6.00, @karaoke_bar.customer_spending())
  end

  def test_customer_spending_increases_with_drink_purchase()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.serve_drink_to_customer(@customer1, @drink1)
    assert_equal(8.00, @karaoke_bar.customer_spending())
  end

  def test_customer_spending_increases_with_multiple_purchase()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.serve_drink_to_customer(@customer1, @drink1)
    @karaoke_bar.serve_food_to_customer(@customer1, @food1)
    assert_equal(14.00, @karaoke_bar.customer_spending())
  end

  def test_customer_spending_increases_with_room_entrance_price()
    @karaoke_bar.add_customer_to_room(@room1, @customer1)
    assert_equal(10.00, @room1.customer_spending())
  end

  def test_get_tab()
    assert_equal(0, @karaoke_bar.tab())
  end

  def test_set_tab()
    @karaoke_bar.tab = 100.00
    assert_equal(100.00, @karaoke_bar.tab())
  end

  def test_bar_tab_has_credit__true()
    @karaoke_bar.tab = 10.00
    assert_equal(true, @karaoke_bar.bar_tab_has_credit?(@karaoke_bar, @drink1))
  end

  def test_bar_tab_has_credit__false()
    @karaoke_bar.tab = 5.00
    assert_equal(false, @karaoke_bar.bar_tab_has_credit?(@karaoke_bar, @drink1))
  end

  def test_if_using_bar_tab_food__success()
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.tab = 10.00
    @karaoke_bar.if_using_bar_tab_food(@karaoke_bar, @customer1, @food1)
    assert_equal(4.00, @karaoke_bar.tab())
  end

  def test_if_using_bar_tab_drink__success()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.tab = 10.00
    @karaoke_bar.if_using_bar_tab_drink(@karaoke_bar, @customer1, @drink1)
    assert_equal(2.00, @karaoke_bar.tab())
  end

  def test_if_using_bar_tab_food__fail()
    @karaoke_bar.add_item(@food1)
    @karaoke_bar.tab = 5.00
    @karaoke_bar.if_using_bar_tab_food(@karaoke_bar, @customer1, @food1)
    assert_equal(5.00, @karaoke_bar.tab())
  end

  def test_if_using_bar_tab_drink__fail()
    @karaoke_bar.add_item(@drink1)
    @karaoke_bar.tab = 5.00
    @karaoke_bar.if_using_bar_tab_drink(@karaoke_bar, @customer1, @drink1)
    assert_equal(5.00, @karaoke_bar.tab())
  end

end
