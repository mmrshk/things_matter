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
#  position        :integer
#  deleted_date    :date
#  user_account_id :uuid
#

class Task < ApplicationRecord
  acts_as_list scope: :task_project

  belongs_to :task_project, optional: true
  belongs_to :user_account

  has_many :task_images, class_name: 'Attachments::TaskImage', as: :attachable, dependent: :destroy
end
