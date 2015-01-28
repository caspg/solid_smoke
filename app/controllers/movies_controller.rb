class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :search_info]

  def index
  end

  def new
    if params[:title]
      begin
        omdb_service = OmdbServices.new
        @movie_info  = omdb_service.get_info(params[:title])
      rescue
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually."
      end
    end
  end

  def create
  end

  def show
  end

  # Return search results if title is given.
  def search_info
    if params[:title]
      begin
        omdb_service   = OmdbServices.new
        @search_result = omdb_service.search(params[:title])
      rescue 
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually."
      end
    end
  end
end
