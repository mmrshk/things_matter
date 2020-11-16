# frozen_string_literal: true

module Types
	module Inputs
		class NoteRecoverInput < Types::Base::InputObject
			I18N_PATH = 'graphql.inputs.user.task_recover_input'

			graphql_name 'NoteRecoverInput'

			description I18n.t("#{I18N_PATH}.desc")

			argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')
			argument :note_project_id, ID, required: false, description: I18n.t('graphql.inputs.common.fields.id')
		end
	end
end

