FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "phil#{n}tok@ya.ru" }
    sequence(:password) { "12345678" }
    sequence(:password_confirmation) { "12345678" }
  end
end
