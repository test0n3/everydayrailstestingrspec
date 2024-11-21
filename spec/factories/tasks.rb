FactoryBot.define do
  factory :task do
    name { "MyString" }
    project { nil }
    completed { false }
  end
end
