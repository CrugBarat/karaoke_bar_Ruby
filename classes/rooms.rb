require_relative('operations.rb')

class Rooms < Operations

  attr_reader :name, :till, :capacity, :price, :playlist
  attr_writer :till, :capacity, :price

  def initialize(name, till, stock, capacity, price, playlist)
    @name = name
    @till = till
    @stock = stock
    @capacity = capacity
    @price = price
    @customers_array = []
    @playlist = playlist
  end

  def playlist_count()
    @playlist.size()
  end

  def clear_playlist()
    @playlist.clear()
  end

  def add_song_to_playlist(song)
    @playlist.push(song)
  end

end
