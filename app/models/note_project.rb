# frozen_string_literal: true

# == Schema Information
#
# Table name: note_projects
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  deadline        :date
#  note_area_id    :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#

class NoteProject < ApplicationRecord
  acts_as_list

  belongs_to :user_account
  belongs_to :note_area, optional: true

  has_many :notes, dependent: :destroy
end
