require_relative('operations.rb')

class Rooms < Operations

  attr_reader :name, :till, :stock, :capacity, :price, :playlist, :customer_spending, :tab
  attr_writer :till, :capacity, :price, :customer_spending, :tab

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
    @customer_spending = 0.00
    @tab = 0.00
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

  def get_lyrics(title)
    song = get_song_by_title(title)
    return song.lyrics
  end

  def display_lyrics(title)
    lyrics = get_lyrics(title)
    lyrics.each {|lyric| puts lyric}
  end

end
