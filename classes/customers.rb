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

end
