# frozen_string_literal: true

module Types
  module Inputs
    class ProjectCreateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.project_create_input'

      graphql_name 'ProjectCreateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :name,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :deadline,
               GraphQL::Types::ISO8601DateTime,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.deadline")

      argument :type,
               Types::Enums::ProjectTypeEnum,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.deadline")

      argument :area_id,
               ID,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.area_id")
    end
  end
end
