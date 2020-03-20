require_relative('operations.rb')

class KaraokeBar < Operations

  attr_reader :name, :till, :rooms
  attr_writer :till

  def initialize(name, till, stock, rooms)
    @name = name
    @till = till
    @stock = stock
    @rooms = rooms
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
    room.add_customer(customer)
  end

end
