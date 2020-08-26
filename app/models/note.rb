# == Schema Information
#
# Table name: notes
#
#  id              :uuid             not null, primary key
#  name            :string
#  description     :text
#  default         :boolean          default(FALSE)
#  areas_id        :uuid
#  projects_id     :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Note < ApplicationRecord
  has_one :user_account

  belongs_to :area
  belongs_to :project
end
