FactoryBot.define do
  factory :comment do
    sequence(:description) { |n| "TEST_DESCRIPTION#{n}" }

    association :post
    association :user
  end
end
