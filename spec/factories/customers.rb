FactoryGirl.define do
  factory :customer do
    sequence(:name) { |n| "John Doe #{n}" }
    sequence(:email) { |n| "joe#{n}@example.com" }
  end
end
