# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    transient do
      is_deleted { false }
    end

    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    default { false }
    deleted { false }

    user_account
    note_project { FactoryBot.create(:note_project, user_account: user_account) }

    after(:create) do |note, evaluator|
      note.update(deleted: true, deleted_date: Time.zone.today - 1.day) if evaluator.is_deleted
    end
  end
end
