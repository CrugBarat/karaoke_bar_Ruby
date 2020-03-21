require_relative('operations.rb')

class KaraokeBar < Operations

  attr_reader :name, :till, :stock, :rooms, :price
  attr_writer :till, :price

  def initialize(name, till, rooms, price)
    @name = name
    @till = till
    @stock = Hash.new()
    @rooms = rooms
    @price = price
    @customers_array = []
    @age_limit = 18
    @drunkness_level = 50
  end

  def room_count()
    @rooms.size()
  end

  def add_new_room(room)
    @rooms.push(room)
  end

  def room_capacity_full?(room)
    if room.capacity <= room.customer_count
      return true
    else
      return false
    end
  end

  def add_customer_to_room(room, customer)
    return if !room.customer_has_cash?(customer, room)
    return if !room.customer_is_above_age?(customer)
    return if room_capacity_full?(room)
    return if room.customer_too_drunk?(customer)
    room.add_customer(customer)
    customer.pay(room.price)
    add_money_to_till(room.price)
  end

end
