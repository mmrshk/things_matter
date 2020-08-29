# frozen_string_literal: true

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

class Area < ApplicationRecord
  belongs_to :user_account

  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy
end
