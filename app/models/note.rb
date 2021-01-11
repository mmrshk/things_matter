# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id              :uuid             not null, primary key
#  name            :string           default("")
#  description     :text
#  default         :boolean          default(FALSE)
#  note_project_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position        :integer
#  deleted         :boolean          default(FALSE)
#  deleted_date    :date
#  user_account_id :uuid
#

class Note < ApplicationRecord
  acts_as_list scope: :note_project

  belongs_to :user_account
  belongs_to :note_project

  has_many :note_images, dependent: :destroy
end
