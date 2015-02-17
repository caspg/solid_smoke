class MovieRatingsController < ApplicationController
  before_action :authenticate_user! 
  before_action :authenticate_author, only: :update

  def create
    @movie_rating = current_user.movie_ratings.new(rating_params)
    if @movie_rating.save
      redirect_to movie, flash: { success: 'rating saved successfully' }
    else
      redirect_to movie, flash: { warning: 'could not save rating' }
    end
  end

  def update
    @movie_rating = MovieRating.find(params[:id])
    if @movie_rating.update_attributes(score: rating_params[:score])
      redirect_to movie, flash: { success: 'ok' }
    else
      redirect_to movie, flash: { warning: 'not ok' }
    end
  end

  private

    def rating_params
      params.require(:movie_rating).permit(:movie_id, :score)
    end

    def movie
      movie_path(rating_params[:movie_id])
    end

    # Test if current user is rating author. If not redirect to movie.
    def authenticate_author 
      if current_user != MovieRating.find(params[:id]).user
        redirect_to movie, flash: { danger: 'You are not allowed to edit this rating.' } 
      end
    end

end
