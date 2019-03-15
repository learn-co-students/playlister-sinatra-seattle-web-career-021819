class Genre < ActiveRecord::Base

  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    slug_name = self.name.downcase.gsub(/ /, '-')
    slug_name
  end

  def self.find_by_slug(slug)
    result = Genre.all.select do |genre|
      genre.slug == slug
    end
    result[0]
  end

end
