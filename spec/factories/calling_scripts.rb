FactoryGirl.define do
  factory :calling_script do
    content "Hello %{representative}, this is %{constituent} calling to say hi"
    topic "Greetings"
    summary "a way to just say hi"
    user
  end
end
