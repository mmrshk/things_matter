# == Schema Information
#
# Table name: task_images
#
#  id         :uuid             not null, primary key
#  task_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NoteImage < ApplicationRecord
  acts_as_list scope: :note

  belongs_to :note

  has_one_attached :file
end
