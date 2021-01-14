# frozen_string_literal: true

module Types
  module Inputs
    class NoteTagUpdateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.note_tag_update_input'

      graphql_name 'NoteTagUpdateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :name,
               String,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :id,
               ID,
               required: true,
               description: I18n.t('graphql.inputs.common.fields.id')
    end
  end
end
