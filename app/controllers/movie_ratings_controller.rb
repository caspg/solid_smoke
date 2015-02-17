class MovieRatingsController < ApplicationController
  def create
    @movie_rating = current_user.movie_ratings.new(rating_params)
    if @movie_rating.save
      redirect_to :back, flash: { success: 'rating saved successfully' }
    else
      redirect_to :back, flash: { warning: 'could not save rating' }
    end
  end

  def update
    @movie_rating = MovieRating.find(params[:id])
    if @movie_rating.update_attributes(score: rating_params[:score])
      redirect_to :back, flash: { success: 'ok' }
    else
      redirect_to :back, flash: { warning: 'not ok' }
    end
  end

  private

    def rating_params
      params.require(:movie_rating).permit(:movie_id, :score)
    end

end
