# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  deadline        :date
#  type            :string           not null
#  area_id         :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :project do
    transient do
      with_area { true }
    end

    name { FFaker::Lorem.word }
    type { 'TaskProject' }
    deadline { Time.zone.now + 1.day }

    user_account

    after(:build) do |project, evaluator|
      project.area_id = create(:area, user_account: project.user_account).id if evaluator.with_area
    end
  end
end
