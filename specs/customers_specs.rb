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

    def test_customer_cheers_when_fav_song_is_played()
      result = @customer2.customer_cheers_at_fav_song(@song1)
      assert_equal("Woohoo!", result)
    end

    def test_customer_sings_when_fav_song_is_played()
      result = @customer2.customer_sings_lyrics(@song1)
      assert_equal(@lyrics1, result)
    end

    def test_customer_requests_fav_song__song1()
      assert_equal(@song1, @customer2.request_fav_song(@room1))
    end

    def test_customer_requests_fav_song__song3()
      assert_equal(@song3, @customer1.request_fav_song(@room1))
    end

    def test_customer_drunkness_drunkness60()
      @customer2.consume_drink(@drink2)
      expected = "Listen. Naw listen. You are ma best mate. I totally mean that"
      assert_equal(expected, @customer2.customer_drunkness_prompts())
    end

    def test_customer_drunkness_prompts__drunkness70()
      @customer2.consume_drink(@drink3)
      expected = "Pftft skkdi lmskmcsc okmslkllsm"
      assert_equal(expected, @customer2.customer_drunkness_prompts())
    end

    def test_customer_drunkness_prompts__drunkness80()
      @customer2.consume_drink(@drink4)
      @customer2.customer_drunkness_prompts()
      assert_equal(50, @customer2.drunkness())
    end

  end
