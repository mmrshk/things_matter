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
#
FactoryBot.define do
  factory :task_project do
    transient do
      with_area { true }
    end

    name { FFaker::Lorem.word }
    deadline { Time.zone.now + 1.day }

    user_account

    after(:build) do |project, evaluator|
      project.task_area_id = create(:task_area, user_account: project.user_account).id if evaluator.with_area
    end
  end
end
