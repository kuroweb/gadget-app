FactoryBot.define do
  factory :post do
    sequence(:description) { |n| "TEST_DESCRIPTION#{n}" }

    association :user
  end
end
