# frozen_string_literal: true

module Types
  module Inputs
    class TaskFilterInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.task_filter_input'

      graphql_name 'TaskFilterInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :filter,
               Types::Enums::TaskFilter,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.filter")

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
