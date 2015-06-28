FactoryGirl.define do
  factory :relationship do
    user_1 { create(:user).id }
    user_2 { create(:user).id }
  end
end
