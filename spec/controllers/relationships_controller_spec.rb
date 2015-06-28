require 'rails_helper'

describe RelationshipsController do
  render_views

  let(:user) { create :user }
  let!(:friend) { create :user }
  let!(:not_friend) { create :user }

  describe '#index' do
    it 'responds with an error when not logged in' do
      get :index, format: :json
      expect(response).to be_unauthorized
    end

    context 'logged in' do
      let!(:friend_relation) { create :relationship, user_1: user.id, user_2: friend.id }

      before { sign_in user }

      it 'returns all the relationships of the current user' do
        get :index, format: :json

        parsed = parse_response
        expect(parsed.length).to eq 1
        expect(parsed[0]).to eq({
          'id' => friend_relation.id,
          'user_1' => friend_relation.user_1,
          'user_2' => friend_relation.user_2,
          'status' => 'pending'
        })
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

      it 'creates a relationship with status pending' do
        expect do
          post :create, relationship: {status: 'accepted', user: { email: friend.email }}, format: :json
        end.to change(Relationship, :count).by 1

        parsed = parse_response
        expect(parsed).to include('user_1' => user.id, 'user_2' => friend.id, 'status' => 'pending')
      end
    end
  end

  describe '#update' do
    let!(:relationship) { create :relationship, user_1: user.id, user_2: friend.id }
    let!(:update_params) {{
      relationship: { status: 'accepted' },
      id: relationship.id,
      format: :json
    }}

    it 'responds with an error when not logged in' do
      patch :update, update_params
      expect(response).to be_unauthorized
    end

    context 'logged in' do
      before { sign_in user }

      it 'updates a relationship' do
        patch :update, update_params

        parsed = parse_response
        expect(parsed).to eq('id' => relationship.id, 'user_1' => user.id, 'user_2' => friend.id, 'status' => 'accepted')
      end

      it 'does not permit updating relationships not belonging to the current user' do
        another_relationship = create :relationship

        expect do
          patch :update, update_params.merge(id: another_relationship.id)
        end.to change(Relationship, :count).by 0

        expect(response).to be_forbidden
        expect(response.body).to match /You are not permitted to update a resource that does not belong to you/
      end
    end
  end

  describe '#destroy' do
    let!(:relationship) { create :relationship, user_1: user.id, user_2: friend.id }

    it 'responds with an error when not logged in' do
      delete :destroy, id: relationship.id, format: :json
      expect(response).to be_unauthorized
    end

    context 'logged in' do
      before { sign_in user }

      it 'deletes the relationship' do
        expect do
          delete :destroy, id: relationship.id, format: :json
        end.to change(Relationship, :count).by -1

        expect(response).to be_success
      end

      it 'does not permit deleting relationships not belonging to the current user' do
        another_relationship = create :relationship

        expect do
          delete :destroy, id: another_relationship.id, format: :json
        end.to change(Relationship, :count).by 0

        expect(response).to be_forbidden
        expect(response.body).to match /You are not permitted to destroy a resource that does not belong to you/
      end
    end
  end
end
