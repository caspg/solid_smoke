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
end
