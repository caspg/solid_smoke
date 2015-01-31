class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :search_info]
  helper_method :sort_column, :sort_direction

  def index
    @movies = Movie.order(sort_column + ' ' + sort_direction)
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
    if params[:title] || params[:imdbID]
      begin
        omdb_service = OmdbServices.new
        if method == :search
          # Strip spaces. And convert inside spaces into '+'.
          title= params[:title].strip.gsub(/[[:space:]]/, '+')
          @search_result = omdb_service.search(title)
        elsif method == :get_info
          @movie_info = omdb_service.get_info(params[:imdbID])
        end
      rescue
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually."
      end
    end
  end

  # sort_column and sort_direction set default value of sorting parameter for index action
  def sort_column
    %w[title year].include?(params[:sort]) ? params[:sort] : "year"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
