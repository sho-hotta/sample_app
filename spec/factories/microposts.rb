FactoryBot.define do
  factory :micropost do
    content { "TestText" }
    user { nil }
  end
end
