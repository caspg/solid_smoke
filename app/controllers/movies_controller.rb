require 'open-uri'

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

  def search_info
    if params[:title].present?
      begin
        url =  "http://www.omdbapi.com/?s=#{params[:title]}&r=json"
        json_file = open(url) { |f| f.read }
        @search_result = JSON.parse(json_file)
      rescue 
        flash[:danger] = "Couldn't fetch data! Try later or add movie informations manually"
      end
    end
  end
end
