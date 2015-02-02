class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :search_info]
  helper_method :sort_column, :sort_direction

  def index
    @movies = Movie.order(sort_column + ' ' + sort_direction)
  end

  def new
    @movie = Movie.new
    if params[:imdbID]
      omdb_service = OmdbServices.new
      omdb_service.get_info(params[:imdbID])
    end
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
    @review = Review.new
    @reviews = Review.where(movie_id: params[:id]).order("created_at DESC")
  end

  def search_info
    if params[:title]
      omdb_service = OmdbServices.new
      @search_result = omdb_service.search(params[:title])
    end
  end

  private 

  def movie_params
    params.require(:movie).permit(:title, :year, :runtime, :genre, :director,
                                  :actors, :country, :awards, :poster, :category, 
                                  :plot, :user_id)
  end

  # sort_column and sort_direction set default value of sorting parameter for index action
  def sort_column
    %w[title year].include?(params[:sort]) ? params[:sort] : "year"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
