FactoryBot.define do
  factory :note do
    message { "MyText" }
    project { nil }
    user { nil }
  end
end
