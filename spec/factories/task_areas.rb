# frozen_string_literal: true

# == Schema Information
#
# Table name: task_areas
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#
FactoryBot.define do
  factory :task_area do
    transient do
      with_projects { false }
      project_count { 2 }
    end

    name { FFaker::Lorem.word }

    user_account

    after(:create) do |area, evaluator|
      if evaluator.with_projects
        create_list(:task_project, evaluator.project_count, task_area: area, user_account: area.user_account)
      end
    end
  end
end
