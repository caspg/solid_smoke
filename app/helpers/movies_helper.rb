module MoviesHelper

  def user_wrote_review?
    !Review.where("user_id = ? AND movie_id = ?", current_user.id, params[:id]).empty?
  end
end