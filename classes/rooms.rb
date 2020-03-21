require_relative('operations.rb')

class Rooms < Operations

  attr_reader :name, :till, :stock, :capacity, :price, :playlist
  attr_writer :till, :capacity, :price

  def initialize(name, till, capacity, price, playlist)
    @name = name
    @till = till
    @stock = Hash.new()
    @capacity = capacity
    @price = price
    @customers_array = []
    @playlist = playlist
    @drunkness_level = 40
    @age_limit = 18
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

  def playlist_shuffle()
    @playlist.sample
  end

  def get_song_by_title(title)
    return @playlist.find { |song| song.title == title }
  end

  def get_songs_by_artist(artist)
    return @playlist.find_all { |song| song.artist == artist }
  end

  # def get_lyrics(title)
  #   song = get_song_by_title(title)
  #   return song.lyrics
  # end

  def customer_cheers_at_fav_song(song, customer)
    if customer.fav_song == song.title
      customer.cheers()
    end
  end

end
