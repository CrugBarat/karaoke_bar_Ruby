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
    alcohol_content = drink.alcohol_content
    @drunkness += alcohol_content
  end

  def consume_food(food)
    rejuv_level = food.rejuv_level
    @drunkness -= rejuv_level
  end

  def cheers()
    "Woohoo!"
  end

end
