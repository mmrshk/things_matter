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
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.name")

    field :deadline,
          GraphQL::Types::ISO8601Date,
          null: true,
          description: I18n.t("#{I18N_PATH}.fields.deadline")

    field :notes,
          [Types::NoteType],
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.notes")

    field :tasks,
          [Types::TaskType],
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.tasks")

    field :task_tags,
          [Types::TaskTagType],
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.task_tags"),
          resolver: Resolvers::TaskTags

    def notes
      BatchLoader::GraphQL.for(object.id).batch(default_value: [], cache: false) do |project_ids, loader|
        Note.where(note_project_id: project_ids).each do |note|
          loader.call(object.id) { |memo| memo << note }
        end
      end
    end

    def tasks
      BatchLoader::GraphQL.for(object.id).batch(default_value: [], cache: false) do |project_ids, loader|
        Task.where(task_project_id: project_ids).each do |note|
          loader.call(object.id) { |memo| memo << note }
        end
      end
    end
  end
end
