# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id          :uuid             not null, primary key
#  name        :string           default("")
#  description :text
#  default     :boolean          default(FALSE)
#  project_id  :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Note < ApplicationRecord
  belongs_to :project
end
