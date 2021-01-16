FactoryBot.define do
  factory :user do
    sequence(:uid) { |n| "TEST_UID#{n}"}
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "TEST_EMAIL#{n}@example.com"}
  end
end
