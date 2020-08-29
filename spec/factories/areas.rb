# == Schema Information
#
# Table name: areas
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  type            :string           not null
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :area do
    user_account

    name { FFaker::Lorem.word }
    type { 'TaskArea' }
  end
end
