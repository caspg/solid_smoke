class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save!
      redirect_to movie_path(review_params[:movie_id])
    end
  end

  private 
    def review_params
      params.require(:review).permit(:title, :content, :movie_id)
    end
end
