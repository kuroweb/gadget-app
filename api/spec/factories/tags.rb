FactoryBot.define do
  factory :tag do
    sequence(:tag_name) { |n| "TEST_TAG_NAME#{n}" }
  end
end
