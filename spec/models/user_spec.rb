require 'rails_helper'

describe User do
  it { is_expected.to have_many :albums }
  it { is_expected.to have_many :photos }

  describe '#friends' do
    let!(:user1) { create :user }
    let!(:user2) { create :user }
    let!(:user3) { create :user }
    let!(:relation1) { create :friend, user_1: user1.id, user_2: user2.id }
    let!(:relation2) { create :friend, user_1: user2.id, user_2: user1.id }

    it 'returns the correct friends lists' do
      expect(user1.friends).to eq [user2]
      expect(user2.friends).to eq [user1]
    end
  end
end
