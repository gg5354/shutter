require 'rails_helper'

describe Album do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :photos }
end
