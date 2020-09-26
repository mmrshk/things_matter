# frozen_string_literal: true

# == Schema Information
#
# Table name: user_accounts
#
#  id              :uuid             not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryBot.define do
  factory :user_account do
    transient do
      with_user_profile { false }

      with_note_areas { false }
      note_areas_count { 2 }

      with_task_areas { false }
      task_areas_count { 2 }
    end

    email { FFaker::Internet.unique.email }
    password { 'password' }

    after(:create) do |account, evaluator|
      account.user_profile = create(:user_profile, user_account: account) if evaluator.with_user_profile

      if evaluator.with_note_areas
        create_list(:note_area, evaluator.note_areas_count, user_account: account)
      end

      if evaluator.with_task_areas
        create_list(:task_area, evaluator.task_areas_count, user_account: account)
      end
    end
  end
end
