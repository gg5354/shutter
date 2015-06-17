FactoryGirl.define do
  factory :album do
    sequence(:name) { |n| "name #{n}" }
  end
end
