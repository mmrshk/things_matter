# frozen_string_literal: true

module Types
  class QueryType < Types::Base::Object
    field :me, resolver: Resolvers::Me, description: I18n.t('graphql.queries.me')

    # field :movies_search,
    #       resolver: Resolvers::MoviesSearch,
    #       connection: true,
    #       description: I18n.t('graphql.queries.movies_search')
    #
    # field :movie,
    #       resolver: Resolvers::Movie,
    #       connection: false,
    #       description: I18n.t('graphql.queries.movie')

    field :tasks,
          resolver: Resolvers::Tasks,
          connection: true,
          description: I18n.t('graphql.queries.tasks')

    field :notes,
          resolver: Resolvers::Notes,
          connection: true,
          description: I18n.t('graphql.queries.notes')

    field :projects,
          resolver: Resolvers::Projects,
          connection: true,
          description: I18n.t('graphql.queries.projects')
  end
end
