class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save!
      redirect_to movie_path(review_params[:movie_id])
    end
  end

  def vote   
    vote = current_user.review_votes.new(value: params[:value], review_id: params[:id])
    if vote.save
      redirect_to :back, flash: { success: "Thank you for voting." }
    else
      redirect_to :back, flash: { warning: "Unable to vote." }
    end
  end

  private 
    def vote_params
      params.require(:review).permit(:value, :review_id)
    end

    def review_params
      params.require(:review).permit(:title, :content, :movie_id)
    end
end
