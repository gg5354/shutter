require 'rails_helper'

describe User do
  let(:user1) { create :user }
  let(:user2) { create :user }
  let(:user3) { create :user }
  let(:user4) { create :user }
  let(:user5) { create :user }

  before do
    create :relationship, user_1: user1.id, user_2: user2.id, status: Relationship::STATUS[:accepted]
    create :relationship, user_1: user4.id, user_2: user1.id, status: Relationship::STATUS[:accepted]
    create :relationship, user_1: user1.id, user_2: user3.id
    create :relationship, user_1: user5.id, user_2: user1.id
  end

  it { is_expected.to have_many :albums }
  it { is_expected.to have_many :photos }

  describe '#friends' do
    it 'returns accepted friends by default' do
      expect(user1.friends).to match_array [user2, user4]
    end

    it 'returns pending friends' do
      expect(user1.friends status: 'pending').to match_array [user3, user5]
    end
  end
end
