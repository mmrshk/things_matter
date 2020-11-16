# frozen_string_literal: true

# == Schema Information
#
# Table name: note_areas
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#  deleted_date    :date
#  deleted         :boolean          default(FALSE)
#
FactoryBot.define do
  factory :note_area do
    transient do
      with_projects { false }
      project_count { 2 }
      is_deleted { false }
    end

    name { FFaker::Lorem.word }
    user_account

    after(:create) do |area, evaluator|
      if evaluator.with_projects
        create_list(:note_project, evaluator.project_count, note_area: area, user_account: area.user_account)
      end

      area.update(deleted: true, deleted_date: Time.zone.today) if evaluator.is_deleted
    end
  end
end
