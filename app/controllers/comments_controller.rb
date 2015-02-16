class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to :back, flash: { success: "Comment successfully added!" }
    else 
      redirect_to :back, flash: { warning: "Couldn't create comment!"}
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :review_id)
    end
end
