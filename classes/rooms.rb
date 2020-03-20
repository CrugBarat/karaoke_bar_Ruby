require_relative('operations.rb')

class Rooms < Operations

  attr_reader :name, :till, :capacity, :fee, :playlist
  attr_writer :till, :capacity, :fee

  def initialize(name, till, stock, capacity, fee, playlist)
    @name = name
    @till = till
    @stock = stock
    @capacity = capacity
    @fee = fee
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
