# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    transient do
      is_deleted { false }
      with_image { false }
      image_count { 1 }
    end

    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    default { false }
    deleted { false }

    user_account
    note_project { FactoryBot.create(:note_project, user_account: user_account) }

    after(:create) do |note, evaluator|
      note.update(deleted: true, deleted_date: Time.zone.today - 1.day) if evaluator.is_deleted

      create_list(:note_image, evaluator.image_count, note: note) if evaluator.with_image
    end
  end
end
