# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    default { false }
    deleted { false }

    note_project
  end
end
