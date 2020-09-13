# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  description     :text
#  done            :boolean          default(FALSE)
#  deleted         :boolean          default(FALSE)
#  deadline        :date
#  to_do_day       :date
#  task_project_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Task < ApplicationRecord
  belongs_to :task_project
end
