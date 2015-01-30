class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :search_info]

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
    call_omdb_service(:get_info)
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    if @movie.save
      flash[:success] = "Movie successfully added!"
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search_info
    call_omdb_service(:search)
  end

  private 

  def movie_params
    params.require(:movie).permit(:title, :year, :runtime, :genre, :director,
                                  :actors, :country, :awards, :poster, :category, 
                                  :plot, :user_id)
  end

  # If params are given:
  # call OmbdbService and return hash results or rescue with flash message.
  def call_omdb_service(method)
    if params[:title]
      # Strip spaces. And convert inside spaces into '+'.
      title = params[:title].strip.gsub(/[[:space:]]/, '+')
      begin
        omdb_service = OmdbServices.new
        @search_result = omdb_service.search(title)   if method == :search
        @movie_info = omdb_service.get_info(title) if method == :get_info
      rescue
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually."
      end
    end
  end
end
