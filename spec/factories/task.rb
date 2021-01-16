# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    transient do
      without_task_project { false }
      is_deleted { false }
      with_task_tag { false }
    end

    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    to_do_day { Time.zone.today - 1.day }
    deadline { Time.zone.today + 7.days }

    user_account
    task_project { FactoryBot.create(:task_project, user_account: user_account) }

    after(:create) do |task, evaluator|
      task.update(task_project_id: nil) if evaluator.without_task_project

      task.update(deleted: true, deleted_date: Time.zone.today - 1.day) if evaluator.is_deleted

      create(:task_tag, task: task) if evaluator.with_task_tag
    end
  end
end
