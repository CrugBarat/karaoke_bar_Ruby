class Customers

  attr_accessor :name, :age, :wallet, :drunkness, :fav_song

  def initialize(name, age, wallet, drunkness, fav_song)
    @name = name
    @age = age
    @wallet = wallet
    @drunkness = drunkness
    @fav_song = fav_song
  end

  def pay(amount)
    @wallet -= amount
  end

  def consume_drink(drink)
    @drunkness += drink.alcohol_content
  end

  def consume_food(food)
    @drunkness -= food.rejuv_level
  end

  def cheers()
    "Woohoo!"
  end

  def customer_cheers_at_fav_song(song, customer)
    if customer.fav_song == song.title
      customer.cheers()
    end
  end

  def customer_sings_lyrics(song, customer)
    lyrics = song.lyrics
    if customer.fav_song == song.title
      lyrics.each {|lyric| p lyric.upcase}
    end
  end

end
