# frozen_string_literal: true

# == Schema Information
#
# Table name: note_projects
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  deadline        :date
#  note_area_id    :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#
FactoryBot.define do
  factory :note_project do
    transient do
      with_notes { false }
      note_count { 2 }
    end

    name { FFaker::Lorem.word }
    deadline { Time.zone.now + 1.day }

    note_area
    user_account

    after(:create) do |project, evaluator|
      create_list(:note, evaluator.note_count, note_project: project) if evaluator.with_notes
    end
  end
end
