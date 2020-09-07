# frozen_string_literal: true

module Types
  module Inputs
    class NoteUpdateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.note_update_input'

      graphql_name 'NoteUpdateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')

      argument :name,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :description,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.description")

      argument :default,
               Boolean,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.default")

      argument :project_id,
               ID,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.project_id")
    end
  end
end
