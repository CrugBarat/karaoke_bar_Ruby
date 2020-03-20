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
  end

  def room_count()
    @rooms.size()
  end

  def add_new_room(room)
    @rooms.push(room)
  end

  def room_capacity_reached?(room)
    if room.customer_count >= room.capacity
      return true
    else
      return false
    end
  end

end
