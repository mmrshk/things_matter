# frozen_string_literal: true

module Types
  module Inputs
    class TaskTagUpdateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.task_tag_update_input'

      graphql_name 'TaskTagUpdateInput'

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
