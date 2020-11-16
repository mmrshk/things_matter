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
#  deleted         :boolean          default(FALSE)
#  deleted_date    :date
#
FactoryBot.define do
  factory :task_project do
    transient do
      with_area { true }
      with_tasks { false }
      with_today_tasks { false }
      is_deleted { false }
      task_count { 2 }
    end

    name { FFaker::Lorem.word }
    deadline { Time.zone.now + 1.day }

    user_account

    after(:create) do |project, evaluator|
      project.task_area_id = create(:task_area, user_account: project.user_account).id if evaluator.with_area

      project.update(deleted: true, deleted_date: Time.zone.today) if evaluator.is_deleted

      if evaluator.with_tasks
        create_list(:task, evaluator.task_count, task_project: project, user_account: project.user_account)
      end

      if evaluator.with_today_tasks
        create_list(:task, evaluator.task_count, task_project: project, user_account: project.user_account,
                                                 to_do_day: Time.zone.today)
      end
    end
  end
end
