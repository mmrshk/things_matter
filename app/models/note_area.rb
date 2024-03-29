# frozen_string_literal: true

# == Schema Information
#
# Table name: note_areas
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#  deleted_date    :date
#  deleted         :boolean          default(FALSE)
#

class NoteArea < ApplicationRecord
  acts_as_list scope: :user_account

  belongs_to :user_account

  has_many :note_projects, dependent: :destroy
  has_many :notes, through: :note_projects, dependent: :destroy
end
