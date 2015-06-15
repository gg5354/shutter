require 'rails_helper'

describe FriendsController do
  render_views

  let(:user) { create :user }
  let(:another_user) { create :user }

  describe '#index' do
    it 'responds with an error when not logged in' do
      get :index, format: :json
      expect(response).to be_unauthorized
    end

    context 'logged in' do
      let!(:friend) { create :user }
      let!(:relation) { create :friend, user_1: user.id, user_2: friend.id, status: Friend::STATUS[:accepted] }

      before { sign_in user }

      it "returns the user's friends list" do
        get :index, format: :json

        parsed = parse_response
        expect(parsed).to match_array([{
          'first_name' => friend.first_name,
          'last_name' => friend.last_name,
          'email' => friend.email
        }])
      end
    end
  end

  describe '#create' do
    it 'responds with an error when not logged in' do
      post :create, format: :json
      expect(response).to be_unauthorized
    end

    context 'logged in' do
      before { sign_in user }

      it 'creates two records for a friend relationship' do
        expect do
          post :create, user_id: another_user.id, format: :json
        end.to change(Friend, :count).by 2

        parsed = parse_response
        expect(parsed).to match_array([
          { 'user_1' => user.id, 'user_2' => another_user.id, 'status' => 'pending' },
          { 'user_1' => another_user.id, 'user_2' => user.id, 'status' => 'pending' }
        ])
      end
    end
  end

  describe '#update_status' do
    it 'responds with an error when not logged in' do
      patch :update_status, user_id: another_user.id, format: :json
      expect(response).to be_unauthorized
    end

    context 'logged in' do
      before do
        create :friend, user_1: user.id, user_2: another_user.id, status: Friend::STATUS[:pending]
        create :friend, user_1: another_user.id, user_2: user.id, status: Friend::STATUS[:pending]
        sign_in another_user
      end

      it 'updates the status' do
        patch :update_status, user_id: user.id, status: 'accepted', format: :json

        parsed = parse_response
        expect(parsed).to match_array([
          { 'user_1' => user.id, 'user_2' => another_user.id, 'status' => 'accepted' },
          { 'user_1' => another_user.id, 'user_2' => user.id, 'status' => 'accepted' }
        ])
      end
    end
  end
end
