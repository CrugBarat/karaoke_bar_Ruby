class Customers

  attr_accessor :name, :age, :wallet, :drunkness, :fav_song, :tray

  def initialize(name, age, wallet, drunkness, fav_song)
    @name = name
    @age = age
    @wallet = wallet
    @drunkness = drunkness
    @fav_song = fav_song
    @tray = []
  end

  def pay(amount)
    @wallet -= amount
  end

  def has_item?(item_name)
    for item in @tray
      if item == item_name
        return true
      end
    end
    return false
  end

  def consume_drink(drink)
    return if !has_item?(drink)
    @tray.delete(drink)
    @drunkness += drink.alcohol_content
  end

  def consume_food(food)
    return if !has_item?(food)
    @tray.delete(food)
    @drunkness -= food.rejuv_level
  end

  def give_item(customer, item)
    return if !has_item?(item)
    @tray.delete(item)
    customer.tray.push(item)
  end

  def enough_cash?(item)
    @wallet >= item.price
  end

  def cheers()
    "Woohoo!"
  end

  def cheers_at_fav_song(song)
    if @fav_song == song.title
      cheers()
    end
  end

  def add_money_to_tab(room, amount)
    @wallet -= amount
    room.tab += amount
  end

  def sings_lyrics(song)
    lyrics = song.lyrics
    if @fav_song == song.title
      lyrics.each {|lyric| p lyric.upcase}
    end
  end

  def request_fav_song(room)
    title = @fav_song
    room.get_song_by_title(title)
  end

  def drunkness_prompts()
    if @drunkness >= 60 && @drunkness < 70
      "Listen. Naw listen. Yer ma best pal. I mean it man!"
    elsif @drunkness >= 70 && @drunkness < 80
      "Pftft skkdi lmskmcsc okmslkllsm"
    elsif @drunkness >= 80
      customer_spews()
    elsif @drunkness < 60
      "Shots?"
    end
  end

  def customer_spews()
    if @drunkness >= 80
      @drunkness -= 30
    end
  end

end
