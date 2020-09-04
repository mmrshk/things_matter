FactoryBot.define do
  factory :note do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    default { false }

    project
  end
end
