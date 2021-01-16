FactoryBot.define do
  factory :board_comment do
    sequence(:description) { |n| "TEST_DESCRIPTION#{n}" }

    association :board
    association :user
  end
end
