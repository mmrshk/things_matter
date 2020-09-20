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
    user_account

    name { FFaker::Lorem.word }
    sequence(:position) { |n| n }
  end
end