# frozen_string_literal: true

module Types
  class ProjectType < Types::Base::Object
    I18N_PATH = 'graphql.types.project_type'

    graphql_name 'ProjectType'

    description I18n.t("#{I18N_PATH}.desc")

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :name,
          String,
          null: true,
          description: I18n.t("#{I18N_PATH}.fields.name")

    field :type,
          String,
          null: true,
          description: I18n.t("#{I18N_PATH}.fields.type")

    field :deadline,
          GraphQL::Types::ISO8601DateTime,
          null: true,
          description: I18n.t("#{I18N_PATH}.fields.deadline")


    # field :tasks
  end
end
