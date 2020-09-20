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
      with_area { true }
    end

    name { FFaker::Lorem.word }
    deadline { Time.zone.now + 1.day }

    user_account

    after(:build) do |note_project, evaluator|
      note_project.note_area_id = create(:note_area, user_account: note_project.user_account).id if evaluator.with_area
    end
  end
end
