class Songs

  attr_accessor :title, :artist, :lyrics

  def initialize(title, artist, lyrics)
    @title = title
    @artist = artist
    @lyrics = lyrics
  end

  # def return_lyrics(song, title)
  #   if title == song.title
  #     return song.lyrics
  #   end
  # end

end
