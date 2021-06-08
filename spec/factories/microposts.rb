FactoryBot.define do
  factory :micropost do
    content { "TestText" }
    created_at { 10.minutes.ago }
    user
  end
end
