# frozen_string_literal: true

FactoryBot.define do
  factory :task_tag do
    name { FFaker::Lorem.word }
    task
  end
end
