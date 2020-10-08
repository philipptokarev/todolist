FactoryBot.define do
  factory :task do
    association :project, factory: :project
    sequence(:name) { |n| "#{project.name} task #{n}" }
    sequence(:deadline) { |n| Date.today + n.days}
  end
end
