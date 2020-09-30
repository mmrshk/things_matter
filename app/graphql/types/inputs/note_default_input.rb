# frozen_string_literal: true

module Types
  module Inputs
    class NoteDefaultInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.note_default_input'

      graphql_name 'NoteDefaultInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')
    end
  end
end
