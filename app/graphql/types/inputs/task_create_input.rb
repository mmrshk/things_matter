# frozen_string_literal: true

module Types
  module Inputs
    class TaskCreateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.task_create_input'

      graphql_name 'TaskCreateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :name,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :description,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.description")

      argument :to_do_day,
               GraphQL::Types::ISO8601DateTime,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.to_do_day")

      argument :deadline,
               GraphQL::Types::ISO8601DateTime,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.deadline")

      argument :project_id,
               ID,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.project_id")
    end
  end
end
