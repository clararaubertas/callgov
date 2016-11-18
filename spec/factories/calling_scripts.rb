FactoryGirl.define do
  factory :calling_script do
    content "Hello"
    topic "Greetings"
    user
  end
end
