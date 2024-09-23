FactoryBot.define do
  factory :note do
    title { "note one title" }
    body { "note one body" }
    association :project
  end
end
