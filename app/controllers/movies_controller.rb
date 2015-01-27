class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  # Search for a movie in OMDb (The Open Movie Database)
  # and return hash with matching titles.
  def search_info
  end
end
