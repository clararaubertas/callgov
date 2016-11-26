FactoryGirl.define do
  factory :calling_script do
    content { Faker::Lorem.paragraphs.join}
    topic {Faker::Lorem.words.to_sentence}
    summary {Faker::Lorem.sentence}
    user
  end
end
