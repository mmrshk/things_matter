# frozen_string_literal: true

module Types
  class AreaType < Types::Base::Object
    graphql_name 'AreaType'

    description I18n.t('graphql.types.area_type.desc')

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :name,
          String,
          null: true,
          description: I18n.t('graphql.types.area_type.fields.name')

    field :type,
          String,
          null: true,
          description: I18n.t('graphql.types.area_type.fields.type')

    field :projects,
          [Types::ProjectType],
          null: false,
          description: I18n.t('graphql.types.area_type.fields.projects')

    def projects
      BatchLoader::GraphQL.for(object.id).batch(default_value: [], cache: false) do |area_ids, loader|
        Project.where(area_id: area_ids).each do |project|
          loader.call(object.id) { |memo| memo << project }
        end
      end
    end
  end
end
