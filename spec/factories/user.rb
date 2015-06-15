FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "first #{n}" }
    sequence(:last_name) { |n| "last #{n}" }
    sequence(:email) { |n| "email#{n}@gmail.com" }

    password 'password123'
  end
end
