class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_author, only: [:destroy]

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to movie_path(review_params[:movie_id]), flash: { success: 'Review successfully created!' }
    else
      redirect_to movie_path(review_params[:movie_id]), flash: { warning: 'Could not create a review!' }
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

  def destroy
    review = Review.find(params[:id])
    if review.destroy
      redirect_to :back, flash: { success: 'Review successfully deleted!' }
    else
      redirect_to :back, flash: { warning: "Couldn't delete review!"}
    end
  end

  private 

    def authenticate_author
      if current_user != Review.find(params[:id]).user
        redirect_to root_path, flash: { danger: 'You are not allowed to delete this review.' }  
      end
    end

    def vote_params
      params.require(:review).permit(:value, :review_id)
    end

    def review_params
      params.require(:review).permit(:title, :content, :movie_id)
    end
end
