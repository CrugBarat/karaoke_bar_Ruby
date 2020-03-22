require("minitest/autorun")
require('minitest/reporters')
require_relative('../classes/customers.rb')
require_relative('../classes/drinks.rb')
require_relative('../classes/food.rb')
require_relative('../classes/songs.rb')
require_relative('../classes/rooms.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestCustomers < MiniTest::Test

  def setup()
    @customer1 = Customers.new("Frank", 35, 45.00, 5, "A Little Respect")
    @drink1 = Drinks.new("Tennents", :Lager, 4.00, 5)
    @drink2 = Drinks.new("Tequila", :Shot, 3.00, 20)
    @drink3 = Drinks.new("Sambuca", :Shot, 3.00, 30)
    @drink4 = Drinks.new("Absinthe", :Shot, 3.00, 40)
    @food1 = Food.new("Burger", 6.00, 15)
    @customer2 = Customers.new("Aldo", 40, 65.00, 40, "Oh L'Amour")
    @customer3 = Customers.new("Ally", 17, 3.00, 0, "Dancing Queen")
    @lyrics1 = ["Oh l'amour",
      "Oh l'amour",
      "Mon amour",
      "What's a boy in love",
      "Supposed to do?"]
      @song1 = Songs.new("Oh L'Amour", "Erasure", @lyrics1)
      @song3 = Songs.new("A Little Respect", "Erasure", @lyrics3)
      @playlist = [@song1, @song3]
      @room1 = Rooms.new("Elvis Room", 30.00, 8, 10.00, @playlist)
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

    def test_get_tray()
      assert_equal([], @customer1.tray())
    end

    def test_set_tray()
      @customer1.tray = [@drink1]
      assert_equal([@drink1], @customer1.tray())
    end

    def test_customer_can_pay()
      @customer1.pay(6.00)
      assert_equal(39.00, @customer1.wallet())
    end

    def test_customer_has_item__true()
      @room1.add_item_to_customer(@customer1, @drink1)
      @room1.add_item_to_customer(@customer1, @food1)
      assert_equal(true, @customer1.has_item?(@drink1))
    end

    def test_customer_has_item__false()
      assert_equal(false, @customer1.has_item?(@drink1))
    end

    def test_customer_can_consume_drink()
      @room1.add_item_to_customer(@customer1, @drink1)
      @room1.add_item_to_customer(@customer1, @drink2)
      @customer1.consume_drink(@drink1)
      assert_equal(10, @customer1.drunkness())
      assert_equal([@drink2], @customer1.tray())
    end

    def test_customer_can_consume_food()
      @room1.add_item_to_customer(@customer1, @food1)
      @customer1.consume_food(@food1)
      assert_equal(-10, @customer1.drunkness())
      assert_equal([], @customer1.tray())
    end

    def test_customer_cant_consume__no_item()
      @customer1.consume_food(@food1)
      assert_equal(5, @customer1.drunkness())
    end

    def test_customer_can_give_item_to_another_customer()
      @room1.add_item_to_customer(@customer1, @drink1)
      @room1.add_item_to_customer(@customer1, @drink2)
      @customer1.give_item(@customer2, @drink2)
      assert_equal([@drink2], @customer2.tray())
      assert_equal([@drink1], @customer1.tray())
    end

    def test_customer_can_afford_drink__true()
      assert_equal(true, @customer1.enough_cash?(@drink1))
    end

    def test_customer_can_afford_drink__false()
      assert_equal(false, @customer3.enough_cash?(@drink1))
    end

    def test_customer_can_afford_food__true()
      assert_equal(true, @customer1.enough_cash?(@food1))
    end

    def test_customer_can_afford_food__false()
      assert_equal(false, @customer3.enough_cash?(@food1))
    end

    def test_customer_can_afford_room_fee__true()
      assert_equal(true, @customer1.enough_cash?(@room1))
    end

    def test_customer_can_afford_room_fee__false()
      assert_equal(false, @customer3.enough_cash?(@room1))
    end

    def test_customer_can_cheers()
      assert_equal("Woohoo!", @customer1.cheers())
    end

    def test_customer_cheers_when_fav_song_is_played()
      result = @customer2.cheers_at_fav_song(@song1)
      assert_equal("Woohoo!", result)
    end

    def test_customer_sings_when_fav_song_is_played()
      result = @customer2.sings_lyrics(@song1)
      assert_equal(@lyrics1, result)
    end

    def test_customer_requests_fav_song__song1()
      assert_equal(@song1, @customer2.request_fav_song(@room1))
    end

    def test_customer_requests_fav_song__song3()
      assert_equal(@song3, @customer1.request_fav_song(@room1))
    end

    def test_customer_drunkness_drunkness60()
      @room1.add_item_to_customer(@customer2, @drink2)
      @customer2.consume_drink(@drink2)
      expected = "Listen. Naw listen. Yer ma best pal. I mean it man!"
      assert_equal(expected, @customer2.drunkness_prompts())
    end

    def test_customer_drunkness_prompts__drunkness70()
      @room1.add_item_to_customer(@customer2, @drink3)
      @customer2.consume_drink(@drink3)
      expected = "Pftft skkdi lmskmcsc okmslkllsm"
      assert_equal(expected, @customer2.drunkness_prompts())
    end

    def test_customer_drunkness_prompts__drunkness80()
      @room1.add_item_to_customer(@customer2, @drink4)
      @customer2.consume_drink(@drink4)
      @customer2.drunkness_prompts()
      assert_equal(50, @customer2.drunkness())
    end

    def test_customer_can_add_money_to_tab()
      @room1.tab = 50.00
      @customer2.add_money_to_tab(@room1, 35.00)
      assert_equal(85.00, @room1.tab())
      assert_equal(30.00, @customer2.wallet())
    end

  end
