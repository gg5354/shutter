require 'rails_helper'

describe UsersController do
  render_views

  let(:user) { create :user }

  describe '#show' do
    it 'responds with null when not logged in' do
      get :show, format: :json

      expect(response).to be_success
      expect(response.body).to eq 'null'
    end

    context 'when logged in' do
      before { sign_in user }

      it 'returns the current user' do
        get :show, format: :json

        parsed = parse_response
        expect(parsed).to eq({
          'id' => user.id,
          'first_name' => user.first_name,
          'last_name' => user.last_name,
          'email' => user.email
        })
      end
    end
  end

  describe '#friends' do
    it 'responds with an error when not logged in' do
      get :friends, format: :json

      expect(response).to be_unauthorized
    end

    context 'when logged in' do
      let(:friend) { create :user }
      let(:pending) { create :user }

      before do
        create :relationship, user_1: user.id, user_2: friend.id, status: Relationship::STATUS[:accepted]
        create :relationship, user_1: user.id, user_2: pending.id
        sign_in user
      end

      it 'returns a list of accepted friends by default' do
        get :friends, format: :json

        parsed = parse_response
        expect(parsed).to match_array [friend.as_json(only: %i(id first_name last_name email))]
      end

      it 'returns pending friends when requested' do
        get :friends, status: 'pending', format: :json

        parsed = parse_response
        expect(parsed).to match_array [{'id' => pending.id, 'email' => pending.email}]
      end
    end
  end
end
