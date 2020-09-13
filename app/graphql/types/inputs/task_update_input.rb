# frozen_string_literal: true

module Types
  module Inputs
    class TaskUpdateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.task_update_input'

      graphql_name 'TaskUpdateInput'

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

      argument :to_do_day,
               GraphQL::Types::ISO8601Date,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.to_do_day")

      argument :deadline,
               GraphQL::Types::ISO8601Date,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.deadline")

      argument :task_project_id,
               ID,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.project_id")
    end
  end
end
