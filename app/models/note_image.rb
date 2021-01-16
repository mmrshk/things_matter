# frozen_string_literal: true

# == Schema Information
#
# Table name: note_images
#
#  id         :uuid             not null, primary key
#  note_id    :uuid
#  position   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NoteImage < ApplicationRecord
  acts_as_list scope: :note

  belongs_to :note

  has_one_attached :file
end
