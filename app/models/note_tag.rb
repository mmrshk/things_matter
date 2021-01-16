# frozen_string_literal: true

# == Schema Information
#
# Table name: note_tags
#
#  id         :uuid             not null, primary key
#  note_id    :uuid
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NoteTag < ApplicationRecord
  belongs_to :note
end
