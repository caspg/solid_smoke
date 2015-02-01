class StaticPagesController < ApplicationController
  def home
    @movies = Movie.order("created_at desc").limit(10)
  end
end
