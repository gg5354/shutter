require 'rails_helper'

describe User do
  it { is_expected.to have_many :albums }
  it { is_expected.to have_many :photos }
  it { is_expected.to have_many(:friends).conditions(status: Friend::STATUS[:accepted]) }
end
