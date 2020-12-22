# == Schema Information
#
# Table name: task_images
#
#  id         :uuid             not null, primary key
#  task_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TaskImage < ApplicationRecord
  acts_as_list scope: :task

  belongs_to :task

  has_one_attached :file
end
