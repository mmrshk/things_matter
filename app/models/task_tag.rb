# frozen_string_literal: true

# == Schema Information
#
# Table name: task_tags
#
#  id         :uuid             not null, primary key
#  task_id    :uuid
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TaskTag < ApplicationRecord
  belongs_to :task
end
