# frozen_string_literal: true

module Types
  class ListType < Types::Base::Object
    graphql_name 'ListType'
    description I18n.t('graphql.types.list_type.desc')

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :description,
          String,
          null: true,
          description: I18n.t('graphql.types.list_type.fields.description')

    field :name,
          String,
          null: false,
          description: I18n.t('graphql.types.list_type.fields.name')

    field :items,
          [Types::MovieType],
          null: false,
          description: I18n.t('graphql.types.list_type.fields.items')

    def items
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |list_ids, loader|
        ListsMovie.includes(:movie).where(list_id: list_ids).each do |list_movie|
          loader.call(list_movie.list_id) { |memo| memo << list_movie.movie }
        end
      end
    end
  end
end
