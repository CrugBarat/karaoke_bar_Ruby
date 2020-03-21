require_relative('operations.rb')

class KaraokeBar < Operations

  attr_reader :name, :till, :stock, :rooms, :price, :customer_spending, :capacity, :tab
  attr_writer :till, :price, :customer_spending, :tab

  def initialize(name, till, rooms, price)
    @name = name
    @till = till
    @stock = Hash.new()
    @rooms = rooms
    @price = price
    @customers_array = []
    @age_limit = 18
    @drunkness_level = 50
    @customer_spending = 0.00
    @capacity = 75
    @tab = 0.00
  end

  def room_count()
    @rooms.size()
  end

  def add_new_room(room)
    @rooms.push(room)
  end

end
