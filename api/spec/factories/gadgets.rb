FactoryBot.define do
  factory :gadget do
    sequence(:title) { |n| "TEST_TITLE#{n}" }
    sequence(:good_description) { |n| "TEST_GOOD_DESCRIPTION#{n}" }
    sequence(:bad_description) { |n| "TEST_BAD_DESCRIPTION#{n}" }
    stars { 5 }

    association :user
  end
end
