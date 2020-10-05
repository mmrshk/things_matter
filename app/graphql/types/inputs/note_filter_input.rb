# frozen_string_literal: true

module Types
  module Inputs
    class NoteFilterInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.note_filter_input'

      graphql_name 'NoteFilterInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :sort,
               Types::Enums::TaskNotePropertySort,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.sort")

      argument :direction,
               Types::Enums::DirectionEnum,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.direction"),
               default_value: Types::Enums::DirectionEnum.values['ASC'].value
    end
  end
end
