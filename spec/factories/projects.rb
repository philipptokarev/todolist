FactoryBot.define do
  factory :project do
    association :user, factory: :user
    sequence(:name) { |n| "Project #{n}" }
  end
end
