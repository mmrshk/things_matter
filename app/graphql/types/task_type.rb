# frozen_string_literal: true

module Types
  class TaskType < Base::Object
    I18N_PATH = 'graphql.types.task_type'

    graphql_name 'TaskType'
    description I18n.t("#{I18N_PATH}.desc")

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :description,
          String,
          null: true,
          description: I18n.t("#{I18N_PATH}.fields.description")

    field :name,
          String,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.name")

    field :done,
          Boolean,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.done")

    field :deleted,
          Boolean,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.deleted")

    field :deadline,
          GraphQL::Types::ISO8601Date,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.deadline")

    field :to_do_day,
          GraphQL::Types::ISO8601Date,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.to_do_day")

    field :task_project_id,
          ID,
          null: true,
          description: I18n.t("#{I18N_PATH}.task_project_id")

    field :task_images,
          [Types::ImageType],
          null: true,
          description: I18n.t("#{I18N_PATH}.task_images")

    def images
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |task_ids, loader|
        ::TaskImage
          .with_attached_file
          .where(task_id: task_ids)
          .each do |task_image|
            loader.call(task_image.id) { |memo| memo << task_image.file }
          end
      end
    end
  end
end
