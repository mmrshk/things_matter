# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id              :uuid             not null, primary key
#  name            :string
#  description     :text
#  done            :boolean          default(FALSE)
#  deleted         :boolean          default(FALSE)
#  deadline        :datetime
#  to_do_day       :datetime
#  area_id         :uuid
#  project_id      :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Task < ApplicationRecord
  belongs_to :user_account

  belongs_to :area
  belongs_to :project
end
