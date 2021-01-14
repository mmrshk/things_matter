# frozen_string_literal: true

module Types
  class TaskTagType < Base::Object
    I18N_PATH = 'graphql.types.task_tag_type'

    graphql_name 'TaskTagType'
    description I18n.t("#{I18N_PATH}.desc")

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :name,
          String,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.name")

    field :task_id,
          ID,
          null: false,
          description: I18n.t("#{I18N_PATH}.task_project_id")
  end
end
