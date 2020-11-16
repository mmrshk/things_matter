# frozen_string_literal: true

module Types
  module Inputs
    class TaskRecoverInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.task_recover_input'

      graphql_name 'TaskRecoverInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')

      argument :task_location,
               Types::Enums::TaskRecoverLocation,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.task_location")
    end
  end
end
