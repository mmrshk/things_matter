# frozen_string_literal: true

module Types
  module Inputs
    class NoteProjectCreateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.project_create_input'

      graphql_name 'NoteProjectCreateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :name,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :deadline,
               GraphQL::Types::ISO8601DateTime,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.deadline")

      argument :note_area_id,
               ID,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.area_id")
    end
  end
end
