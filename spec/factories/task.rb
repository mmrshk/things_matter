# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }

    deleted_date { Time.zone.today }
    to_do_day { Time.zone.today }
    deadline { Time.zone.today + 7.days }

    task_project
  end
end
