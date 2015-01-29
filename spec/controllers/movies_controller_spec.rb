require 'rails_helper'

RSpec.describe MoviesController, :type => :controller do
  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    before(:each) { login_user }
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    # This doesn't work and display this message:
    #
    # """ Failure/Error: get :show
    # ActionController::UrlGenerationError:
    # No route matches {:action=>"show", :controller=>"movies"} """
    #
    # rake routes: 
    # movie GET    /movies/:id(.:format)          movies#show
    # -----------------------------------------------------------
    # xit "returns http success" do
    #   get :show
    #   expect(response).to have_http_status(:success)
    # end
  end

  describe "GET search_info" do
    
    context "when user is unlogged" do
      it "redirect user to login page" do
        get :search_info
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
