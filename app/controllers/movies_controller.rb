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
    if params[:title]
      url =  "http://www.omdbapi.com/?s=#{params[:title]}&r=json"
      # url = "http://www.omdbapi.com/?t=#{params[:title]}&r=json"
      json_file = open(url) { |f| f.read }
      @search_result = JSON.parse(json_file)
    else 
      @search_resul = nil
    end
  end
end
