require 'rails_helper'

describe AlbumsController do
  render_views

  describe '#index' do
    it 'responds with an error when not logged in' do
      get :index, format: :json
      expect(response).to be_unauthorized
    end

    context 'logged in' do
      let(:user) { create :user }
      let(:another_user) { create :user }
      let!(:album1) { create :album, user_id: user.id }
      let!(:album2) { create :album, user_id: another_user.id }

      before { sign_in user }

      it "returns the user's albums" do
        get :index, format: :json

        parsed = parse_response
        expect(parsed).to match_array([
          { 'name' => album1.name, 'id' => album1.id }
        ])
      end
    end
  end
end
