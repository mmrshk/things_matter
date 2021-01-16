# frozen_string_literal: true

FactoryBot.define do
  factory :note_tag do
    name { FFaker::Lorem.word }
    note
  end
end
