FactoryGirl.define do
  factory :user do
    name                   "Test User"
    sequence(:email){|n| "user#{n}@factory.com" }
    password               "password"
    password_confirmation  "password"
    provider "google"
  end
end
