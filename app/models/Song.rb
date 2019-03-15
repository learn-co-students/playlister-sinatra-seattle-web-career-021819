class Song < ActiveRecord::Base

  has_many :song_genres
  has_many :genres, through: :song_genres
  belongs_to :artist

  def slug
    slug_name = self.name.downcase.gsub(/ /, '-')
    slug_name
  end

  def self.find_by_slug(slug)
    result = Song.all.select do |song|
      song.slug == slug
    end
    result[0]
  end

end
