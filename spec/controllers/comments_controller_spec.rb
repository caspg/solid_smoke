require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:user)   { create(:user) }
  let(:review) { create(:review) }
  let(:valid_attributes) do
    {
      content: 'some content', 
      user_id: user.id,
      review_id: review.id
    }
  end

  describe 'POST create' do
    context 'user is not signed in' do
      describe 'with valid params' do
        it 'redirects user to login page' do
          post :create, comment: valid_attributes
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context 'user is signed in' do
      before do
        sign_in user
        request.env['HTTP_REFERER'] = '/movie/:id'
      end

      describe 'with valid params' do
        it 'creates a new Comment' do
          expect {
            post :create, comment: valid_attributes
          }.to change(Comment, :count).by(1)
        end

        it 'redirects to the movie page with success' do
          post :create, { comment: valid_attributes }
          expect(response).to redirect_to('/movie/:id')
          expect(flash[:success]).to_not be_empty
        end
      end

      describe 'with invalid params' do
        it 'does not creates a new Comment' do
          expect {
            post :create, comment: { content: 'invalid attributes' }
          }.to_not change(Comment, :count)
        end

        it 'redirects to the movie page with warning' do
          post :create, comment: { content: 'invalid attributes' }
          expect(response).to redirect_to('/movie/:id') 
          expect(flash[:warning]).to_not be_empty
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let(:user1)    { create(:user) }
    let(:user2)    { create(:user) }
    let!(:comment) { create(:comment, user: user1) }

    context 'user is not signed in' do
      it 'redirects user to login page' do
        delete :destroy, id: comment.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end  

    context 'comment author is signed in' do
      before do
        sign_in user1
        request.env['HTTP_REFERER'] = 'back'
      end

      it 'destroys comment' do
        expect {
            delete :destroy, id: comment.id
          }.to change(Comment, :count).by(-1)
      end

      it 'redirects back with success' do
        delete :destroy, id: comment.id
        expect(response).to redirect_to('back') 
        expect(flash[:success]).to_not be_empty
      end
    end

    context 'another user is signed in' do
      before do
        sign_in user2
      end

      it 'does not destroy comment' do
        expect {
            delete :destroy, id: comment.id
          }.to_not change(Comment, :count)
      end

      it 'redirects to root with danger' do
        delete :destroy, id: comment.id
        expect(response).to redirect_to(root_path) 
        expect(flash[:danger]).to_not be_empty
      end
    end
  end
end
