# frozen_string_literal: true

module Types
  module Inputs
    class TaskTagCreateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.task_tag_create_input'

      graphql_name 'TaskTagCreateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :name,
               String,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :task_id,
               ID,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.task_id")
    end
  end
end
