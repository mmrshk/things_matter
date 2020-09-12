# frozen_string_literal: true

module Types
  class UserAccountType < Base::Object
    I18N_PATH = 'graphql.types.user_account_type'

    graphql_name 'UserAccountType'
    implements Types::Interfaces::Node

    description I18n.t("#{I18N_PATH}.desc")

    field :email,
          String,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.email")

    field :user_profile,
          Types::UserProfileType,
          null: true,
          description: I18n.t("#{I18N_PATH}.fields.user_profile")

    field :task_areas,
          [Types::AreaType],
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.task_areas")

    field :note_areas,
          [Types::AreaType],
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.note_areas")

    field :task_projects,
          [Types::ProjectType],
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.task_projects")

    field :note_projects,
          [Types::ProjectType],
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.note_projects")

    def task_projects
      BatchLoader::GraphQL.for(object.id).batch(default_value: [], cache: false) do |user_account_ids, loader|
        TaskProject.where(user_account_id: user_account_ids).each do |project|
          loader.call(object.id) { |memo| memo << project }
        end
      end
    end

    def note_projects
      BatchLoader::GraphQL.for(object.id).batch(default_value: [], cache: false) do |user_account_ids, loader|
        NoteProject.where(user_account_id: user_account_ids).each do |project|
          loader.call(object.id) { |memo| memo << project }
        end
      end
    end

    def task_areas
      BatchLoader::GraphQL.for(object.id).batch(default_value: [], cache: false) do |user_account_ids, loader|
        TaskArea.where(user_account_id: user_account_ids).each do |area|
          loader.call(object.id) { |memo| memo << area }
        end
      end
    end

    def note_areas
      BatchLoader::GraphQL.for(object.id).batch(default_value: [], cache: false) do |user_account_ids, loader|
        NoteArea.where(user_account_id: user_account_ids).each do |area|
          loader.call(object.id) { |memo| memo << area }
        end
      end
    end
  end
end
