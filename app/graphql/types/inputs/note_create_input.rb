# frozen_string_literal: true

module Types
  module Inputs
    class NoteCreateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.note_create_input'

      graphql_name 'NoteCreateInput'

      description I18n.t("#{I18N_PATH}.desc")

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
               required: true,
               description: I18n.t("#{I18N_PATH}.args.default")

      argument :note_project_id,
               ID,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.project_id")

      argument :note_images,
               [Types::Inputs::ImageType],
               required: false,
               description: I18n.t("#{I18N_PATH}.args.note_images")
    end
  end
end
