# frozen_string_literal: true

module Types
  module Inputs
    class NoteTagCreateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.note_tag_create_input'

      graphql_name 'NoteTagCreateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :name,
               String,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :note_id,
               ID,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.note_id")
    end
  end
end
