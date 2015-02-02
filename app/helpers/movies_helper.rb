module MoviesHelper

  # Return true if user wrote review, false otherwise.
  def user_wrote_review?
    !Review.where("user_id = ? AND movie_id = ?", current_user.id, params[:id]).empty?
  end

  # Set default value for @movie_info.
  # @movie_info is nil when user enter new_movie page without pramas[:title].
  def movie_info
    if @movie_info.nil?
      @movie_info = Hash.new("")
    else
      @movie_info
    end
  end
end