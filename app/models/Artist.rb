class Artist < ActiveRecord::Base

  has_many :songs
  has_many :genres, through: :songs

  def slug
    slug_name = self.name.downcase.gsub(/ /, '-')
    slug_name
  end

  def self.find_by_slug(slug)
    result = Artist.all.select do |artist|
      artist.slug == slug
    end
    result[0]
  end

end
