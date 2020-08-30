# frozen_string_literal: true

module Types
  module Inputs
    class ProjectUpdateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.project_update_input'

      graphql_name 'ProjectUpdateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')

      argument :name,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :deadline,
               GraphQL::Types::ISO8601DateTime,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.deadline")

      argument :area_id,
               ID,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.area_id")
    end
  end
end
