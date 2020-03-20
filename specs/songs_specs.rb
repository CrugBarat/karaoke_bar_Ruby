require("minitest/autorun")
require('minitest/reporters')
require_relative('../songs.rb')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestSongs < MiniTest::Test

  def setup()
    @lyrics1 = ["Oh l'amour",
      "Oh l'amour",
      "Mon amour",
      "What's a boy in love",
      "Supposed to do?"]

      @song1 = Songs.new("Oh L'Amour", "Erasure", @lyrics1)

      @lyrics2 = ["How does it feel", "To treat me like you do?", 'When you\'ve laid your hands upon me', "And told me who you are?"]
    end

    def test_get_title()
      assert_equal("Oh L'Amour", @song1.title())
    end

    def test_get_artist()
      assert_equal("Erasure", @song1.artist())
    end

    def test_get_lyrics()
      assert_equal(@lyrics1, @song1.lyrics())
    end

    def test_set_title()
      @song1.title = "Blue Monday"
      assert_equal("Blue Monday", @song1.title())
    end

    def test_set_artist()
      @song1.artist = "New Order"
      assert_equal("New Order", @song1.artist())
    end

    def test_set_lyrics()
      @song1.lyrics = @lyrics2
      assert_equal(@lyrics2, @song1.lyrics())
    end


  end
