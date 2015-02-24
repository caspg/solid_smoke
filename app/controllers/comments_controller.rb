class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_author, only: [:destroy]

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to :back, flash: { success: "Comment successfully added!" }
    else 
      redirect_to :back, flash: { warning: "Couldn't create comment!"}
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to :back, flash: { success: 'Comment successfully deleted!' }
    else
      redirect_to :back, flash: { warning: "Couldn't delete comment!"}
    end
  end

  private

    def authenticate_author
      if current_user != Comment.find(params[:id]).user
        redirect_to root_path, flash: { danger: 'You are not allowed to delete this comment.' }  
      end
    end

    def comment_params
      params.require(:comment).permit(:content, :review_id)
    end
end
