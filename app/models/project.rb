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

class Project < ApplicationRecord
  belongs_to :user_account
  belongs_to :area, optional: true
end
