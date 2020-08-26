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
          description: I18n.t('graphql.types.area_type.fields.name')

    # field :projects,
    #       [Types::ProjectType],
    #       null: false,
    #       description: I18n.t('graphql.types.list_type.fields.items')

    # TODO: update
    # def projects
    #   BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |area_ids, loader|
    #     Project.includes(:movie).where(list_id: list_ids).each do |list_movie|
    #       loader.call(list_movie.list_id) { |memo| memo << list_movie.movie }
    #     end
    #   end
    # end
  end
end
