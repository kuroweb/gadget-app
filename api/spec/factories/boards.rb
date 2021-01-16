FactoryBot.define do
  factory :board do
    board_type { "雑談" }
    sequence(:description) { |n| "TEST_DESCRIPTION#{n}" }
    sequence(:title) { |n| "TEST_TITLE#{n}" }

    association :user
  end
end
