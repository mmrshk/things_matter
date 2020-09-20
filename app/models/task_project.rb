# frozen_string_literal: true

# == Schema Information
#
# Table name: task_projects
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  deadline        :date
#  task_area_id    :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#

class TaskProject < ApplicationRecord
  acts_as_list

  belongs_to :user_account
  belongs_to :task_area, optional: true

  has_many :tasks, dependent: :destroy
end
