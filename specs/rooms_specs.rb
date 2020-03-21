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
    @lyrics2 = ["How does it feel",
      "To treat me like you do?",
      'When you\'ve laid your hands upon me',
      "And told me who you are?"]
      @song1 = Songs.new("Oh L'Amour", "Erasure", @lyrics1)
      @song2 = Songs.new("Blue Monday", "New Order", @lyrics2)
      @song3 = Songs.new("A Little Respect", "Erasure", @lyrics3)
      @song4 = Songs.new("Restless", "New Order", @lyrics3)
      @playlist = [@song1, @song2, @song3, @song4]
      @new_order = [@song2, @song4]
      @room1 = Rooms.new("Elvis Room", 30.00, 8, 10.00, @playlist)
      @customer1 = Customers.new("Frank", 35, 45.00, 5, "A Little Respect")
      @customer2 = Customers.new("Bea", 21, 5.00, 35, "Come on Eileen")
      @customer3 = Customers.new("Ally", 17, 15.00, 0, "Dancing Queen")
      @customer4 = Customers.new("Colin", 36, 115.00, 55, "Wonderwall")
      @customer5 = Customers.new("Ricky", 37, 50.00, 15, "Supersonic")
      @customer6 = Customers.new("Aldo", 40, 65.00, 40, "Oh L'Amour")
      @drink1 = Drinks.new("Tennents", :Lager, 8.00, 5)
      @food1 = Food.new("Burger", 6.00, 15)
    end

    def test_get_name()
      assert_equal("Elvis Room", @room1.name())
    end

    def test_get_till()
      assert_equal(30.00, @room1.till())
    end

    def test_get_stock()
      assert_equal({}, @room1.stock())
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
      assert_equal(4, @room1.playlist_count())
    end

    def test_clear_playlist()
      @room1.clear_playlist()
      assert_equal(0, @room1.playlist_count())
    end

    def test_add_song_to_playlist()
      @room1.add_song_to_playlist(@song3)
      assert_equal(5, @room1.playlist_count())
    end

    def test_get_song_by_title()
      assert_equal(@song1, @room1.get_song_by_title("Oh L'Amour"))
    end

    def test_get_songs_by_artist()
      assert_equal(@new_order, @room1.get_songs_by_artist("New Order"))
    end

    def test_get_lyrics()
      result = @room1.get_lyrics("Blue Monday")
      assert_equal(@lyrics2, result)
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

    def test_get_stock_level_drink__nil()
      result = @room1.stock_level(@drink1)
      assert_nil(nil, result)
    end

    def test_get_stock_level_food__nil()
      result = @room1.stock_level(@food1)
      assert_nil(nil, result)
    end

    def test_can_add_drink_to_stock()
      assert_equal(1, @room1.add_item(@drink1))
    end

    def test_can_add_multiple_drinks_to_stock()
      @room1.add_item(@drink1)
      @room1.add_item(@drink1)
      @room1.add_item(@drink1)
      result = @room1.stock_level(@drink1)
      assert_equal(3, result)
    end

    def test_can_add_food_to_stock()
      assert_equal(1, @room1.add_item(@food1))
    end

    def test_can_add_multiple_food_to_stock()
      @room1.add_item(@food1)
      @room1.add_item(@food1)
      @room1.add_item(@food1)
      result = @room1.stock_level(@food1)
      assert_equal(3, result)
    end

    def test_get_stock_value__nil()
      assert_nil(nil, @room1.stock_value())
    end

    def test_get_stock_value()
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      assert_equal(28.00, @room1.stock_value())
    end

    def test_get_stock_value_by_item()
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      assert_equal(24.00, @room1.stock_value_by_item(@drink1))
    end

    def test_get_stock_value_by_item()
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      assert_equal(18.00, @room1.stock_value_by_item(@food1))
    end

    def test_serve_food_to_customer__success()
      @room1.add_item(@food1)
      @room1.add_item(@food1)
      @room1.serve_food_to_customer(@customer1, @food1)
      assert_equal(39.00, @customer1.wallet())
      assert_equal(-10, @customer1.drunkness())
      assert_equal(36.00, @room1.till())
      assert_equal(1, @room1.stock_level(@food1))
    end

    def test_serve_food_to_customer__funds_fail()
      @room1.add_item(@food1)
      @room1.add_item(@food1)
      @room1.serve_food_to_customer(@customer2, @food1)
      assert_equal(5.00, @customer2.wallet())
      assert_equal(35, @customer2.drunkness())
      assert_equal(30.00, @room1.till())
      assert_equal(2, @room1.stock_level(@food1))
    end

    def test_serve_food_to_customer__stock_fail()
      @room1.add_item(@food1)
      @room1.serve_food_to_customer(@customer5, @food1)
      @room1.serve_food_to_customer(@customer1, @food1)
      assert_equal(45.00, @customer1.wallet())
      assert_equal(5, @customer1.drunkness())
      assert_equal(36.00, @room1.till())
      assert_equal(0, @room1.stock_level(@food1))
    end

    def test_serve_drink_to_customer__success()
      @room1.add_item(@drink1)
      @room1.add_item(@drink1)
      @room1.serve_drink_to_customer(@customer1, @drink1)
      assert_equal(37.00, @customer1.wallet())
      assert_equal(10, @customer1.drunkness())
      assert_equal(38.00, @room1.till())
      assert_equal(1, @room1.stock_level(@drink1))
    end

    def test_serve_drink_to_customer__age_fail()
      @room1.add_item(@drink1)
      @room1.add_item(@drink1)
      @room1.serve_drink_to_customer(@customer3, @drink1)
      assert_equal(15.00, @customer3.wallet())
      assert_equal(0, @customer3.drunkness())
      assert_equal(30.00, @room1.till())
      assert_equal(2, @room1.stock_level(@drink1))
    end

    def test_serve_drink_to_customer__funds_fail()
      @room1.add_item(@drink1)
      @room1.add_item(@drink1)
      @room1.serve_drink_to_customer(@customer2, @drink1)
      assert_equal(5.00, @customer2.wallet())
      assert_equal(35, @customer2.drunkness())
      assert_equal(30.00, @room1.till())
      assert_equal(2, @room1.stock_level(@drink1))
    end

    def test_serve_drink_to_customer__stock_fail()
      @room1.add_item(@drink1)
      @room1.serve_drink_to_customer(@customer5, @drink1)
      @room1.serve_drink_to_customer(@customer1, @drink1)
      assert_equal(45.00, @customer1.wallet())
      assert_equal(5, @customer1.drunkness())
      assert_equal(38.00, @room1.till())
      assert_equal(0, @room1.stock_level(@drink1))
    end

    def test_serve_drink_to_customer__drunkness_fail()
      @room1.add_item(@drink1)
      @room1.serve_drink_to_customer(@customer4, @drink1)
      assert_equal(115.00, @customer4.wallet())
      assert_equal(55, @customer4.drunkness())
      assert_equal(30.00, @room1.till())
      assert_equal(1, @room1.stock_level(@drink1))
    end

    def test_customer_spending_starts_zero()
      assert_equal(0.00, @room1.customer_spending())
    end

    def test_customer_spending_increases_with_food_purchase()
      @room1.add_item(@food1)
      @room1.serve_food_to_customer(@customer1, @food1)
      assert_equal(6.00, @room1.customer_spending())
    end

    def test_customer_spending_increases_with_drink_purchase()
      @room1.add_item(@drink1)
      @room1.serve_drink_to_customer(@customer1, @drink1)
      assert_equal(8.00, @room1.customer_spending())
    end

    def test_customer_spending_increases_with_multiple_purchase()
      @room1.add_item(@drink1)
      @room1.add_item(@food1)
      @room1.serve_drink_to_customer(@customer1, @drink1)
      @room1.serve_food_to_customer(@customer1, @food1)
      assert_equal(14.00, @room1.customer_spending())
    end

    def test_get_tab()
      assert_equal(0, @room1.tab())
    end

    def test_set_tab()
      @room1.tab = 100.00
      assert_equal(100.00, @room1.tab())
    end

    def test_room_tab_has_credit__true()
      @room1.tab = 10.00
      assert_equal(true, @room1.bar_tab_has_credit?(@room1, @drink1))
    end

    def test_room_tab_has_credit__false()
      @room1.tab = 5.00
      assert_equal(false, @room1.bar_tab_has_credit?(@room1, @drink1))
    end

    def test_if_using_room_tab_food__success()
      @room1.add_item(@food1)
      @room1.tab = 10.00
      @room1.if_using_bar_tab_food(@room1, @customer1, @food1)
      assert_equal(4.00, @room1.tab())
    end

    def test_if_using_room_tab_drink__success()
      @room1.add_item(@drink1)
      @room1.tab = 10.00
      @room1.if_using_bar_tab_drink(@room1, @customer1, @drink1)
      assert_equal(2.00, @room1.tab())
    end

    def test_if_using_room_tab_food__fail()
      @room1.add_item(@food1)
      @room1.tab = 5.00
      @room1.if_using_bar_tab_food(@room1, @customer1, @food1)
      assert_equal(5.00, @room1.tab())
    end

    def test_if_using_room_tab_drink__fail()
      @room1.add_item(@drink1)
      @room1.tab = 5.00
      @room1.if_using_bar_tab_drink(@room1, @customer1, @drink1)
      assert_equal(5.00, @room1.tab())
    end

  end
