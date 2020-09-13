# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }

    to_do_day { Date.today }
    deadline { Date.today + 7.days }

    task_project
  end
end
