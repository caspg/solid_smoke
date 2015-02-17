require 'rails_helper'

RSpec.describe MovieRatingsController, type: :controller do
  let(:user)  { create(:user) }
  let(:movie) { create(:movie) }
  let(:valid_attributes) do
    {
      score: 3,
      user_id: user.id,
      movie_id: movie.id
    }
  end
  let(:movie_rating) { MovieRating.create(valid_attributes) }

  describe 'POST create' do
    context 'user is not signed in' do
      describe 'with valid params' do
        it 'redirects user to login page' do
          post :create, movie_rating: valid_attributes
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context 'user is signed in' do
      before do
        sign_in user
      end

      describe 'with valid params' do
        it 'creates a new MovieRating' do
          expect {
            post :create, movie_rating: valid_attributes
          }.to change(MovieRating, :count).by(1)
        end

        it 'redirects to the movie page with success' do
          post :create, movie_rating: valid_attributes
          expect(response).to redirect_to(movie_path(valid_attributes[:movie_id]))
          expect(flash[:success]).to_not be_empty
        end
      end

      describe 'with invalid params' do
        it 'does not create a new MovieRating' do
          expect {
            post :create, movie_rating: { score: 'invalid attributes', movie_id: movie.id }
          }.to_not change(MovieRating, :count) 
        end

        it 'redirects to the movie page with warning' do
          post :create, movie_rating: { score: 'invalid attributes', movie_id: movie.id }
          expect(response).to redirect_to(movie_path(valid_attributes[:movie_id]))
          expect(flash[:warning]).to_not be_empty 
        end
      end
    end
  end

  describe 'PATCH update' do
    context 'user is not signed in' do
      describe 'with valid params' do
        it 'redirects user to login page' do
          patch :update, { movie_rating: { score: 5, movie_id: movie.id }, id: movie_rating.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context 'user is signed in' do
      before(:each) do
        sign_in user
      end

      describe 'with valid params' do
        before(:each) do
          patch :update, { movie_rating: { score: 5, movie_id: movie.id }, id: movie_rating.id }
          movie_rating.reload
        end

        it 'updates attributes' do
          expect(movie_rating.score).to eql(5)
        end

        it 'redirects to movie page with success' do
          expect(response).to redirect_to(movie_path(movie_rating.movie_id))
          expect(flash[:success]).to_not be_empty
        end
      end

      describe 'with invalid params' do
        before(:each) do
          patch :update, { movie_rating: { score: 'invalid param', movie_id: movie.id }, id: movie_rating.id }
          movie_rating.reload
        end

        it 'does not update attr' do 
          expect(movie_rating.score).to eql(3)
        end

        it 'redirects to the movie page with warning' do
          expect(response).to redirect_to(movie_path(movie_rating.movie_id))
          expect(flash[:warning]).to_not be_empty 
        end
      end
    end

    context 'another user is signed in' do
      let(:user2) { create(:user) }

      before do
        sign_in user2
      end

      describe 'with valid params' do
        before(:each) do
          patch :update, { movie_rating: { score: 5, movie_id: movie.id }, id: movie_rating.id }
          movie_rating.reload
        end

        it 'does not update attr' do
          expect(movie_rating.score).to eql(3)
        end

        it 'redirects to movie page with danger' do
          expect(response).to redirect_to(movie_path(movie_rating.movie_id))
          expect(flash[:danger]).to_not be_empty  
        end
      end
    end
  end
end
