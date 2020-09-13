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
#

class TaskArea < ApplicationRecord
  belongs_to :user_account

  has_many :task_projects, dependent: :destroy
  has_many :tasks, through: :task_projects, dependent: :destroy
end
