class GenresController < ApplicationController

## INDEX ##
  get '/genres' do
    @genres = Genre.all
    erb :"genres/index"
  end

## SHOW ##
  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    @songs = @genre.songs
    @artists = @genre.artists
    erb :"genres/show"
  end

end
