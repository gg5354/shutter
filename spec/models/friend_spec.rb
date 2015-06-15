require 'rails_helper'

describe Friend do
  describe 'create' do
    let(:user) { create :user }
    let(:another_user) { create :user }

    it 'sets the status to pending' do
      friend = Friend.create! user_1: user.id, user_2: another_user.id
      expect(friend.status).to eq Friend::STATUS[:pending]
    end
  end
end
