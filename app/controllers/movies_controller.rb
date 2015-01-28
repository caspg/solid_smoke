class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :search_info]

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  # if given title parameter return search results.
  def search_info
    if params[:title].present?
      begin
        omdb_service  = OmdbServices.new
        @search_result = omdb_service.search(params[:title])
      rescue 
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually."
      end
    end
  end
end
