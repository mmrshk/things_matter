# frozen_string_literal: true

# == Schema Information
#
# Table name: task_projects
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  deadline        :date
#  task_area_id    :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#
FactoryBot.define do
  factory :task_project do
    transient do
      with_tasks { false }
      task_count { 2 }
    end

    name { FFaker::Lorem.word }
    deadline { Time.zone.now + 1.day }

    task_area
    user_account

    after(:create) do |project, evaluator|
      create_list(:task, evaluator.task_count, task_project: project) if evaluator.with_tasks
    end
  end
end
