require 'rails_helper'

describe Relationship do
  it { is_expected.to validate_presence_of(:user_1) }
  it { is_expected.to validate_presence_of(:user_2) }

  it 'validates uniqueness of user_1 scoped to user_2' do
    expect(create :relationship).to validate_uniqueness_of(:user_1).scoped_to(:user_2)
  end

  context 'existing relationship' do
    let(:relationship) { create :relationship }
    let(:user) { create :user }

    %i(user_1 user_2).each do |attribute|
      it "does not allow change to #{attribute}" do
        relationship.update_attributes attribute => user.id
        expect(relationship.errors[attribute]).to eq ['cannot be changed once persisted']
      end
    end

    it 'allows change to status' do
      relationship.update_attributes status: relationship.status + 1
      expect(relationship.errors).to be_empty
    end
  end

  describe 'create' do
    let(:user) { create :user }
    let(:another_user) { create :user }

    it 'defaults status to pending' do
      relationship = Relationship.create! user_1: user.id, user_2: another_user.id
      expect(relationship.status).to eq Relationship::STATUS[:pending]
    end
  end
end
