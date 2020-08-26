# == Schema Information
#
# Table name: projects
#
#  id              :uuid             not null, primary key
#  deadline        :datetime
#  type            :string           not null
#  area_id         :uuid
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class NoteProject < Project; end
