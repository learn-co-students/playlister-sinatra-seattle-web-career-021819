require 'rack-flash'

class SongsController < ApplicationController

  enable :sessions
  use Rack::Flash

## INDEX ##
  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  ## NEW ##
  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all
    erb :"songs/new"
  end

  post '/songs' do
    @song = Song.create(:name => params["name"])
    @song.artist = Artist.find_or_create_by(params[:artist])
    @song.genre_ids = params[:genres]
    @song.save
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

## SHOW ##
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @genres = @song.genres
    @artist = @song.artist
    erb :"songs/show"
  end

## EDIT ##
  get '/songs/:slug/edit' do
    @genres = Genre.all
    @artists = Artist.all
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/edit"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Successfully updated song."

    redirect to "/songs/#{@song.slug}"
  end

end
