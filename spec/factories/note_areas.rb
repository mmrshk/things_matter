# frozen_string_literal: true

# == Schema Information
#
# Table name: note_areas
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#
FactoryBot.define do
  factory :note_area do
    user_account

    name { FFaker::Lorem.word }
  end
end
