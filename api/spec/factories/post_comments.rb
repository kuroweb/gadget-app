FactoryBot.define do
  factory :post_comment do
    sequence(:description) { |n| "TEST_DESCRIPTION#{n}" }

    association :post
    association :user
  end
end
