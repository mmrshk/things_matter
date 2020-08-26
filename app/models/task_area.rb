# frozen_string_literal: true

# == Schema Information
#
# Table name: areas
#
#  id              :uuid             not null, primary key
#  name            :string
#  type            :string           not null
#  user_account_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class TaskArea < Area; end
