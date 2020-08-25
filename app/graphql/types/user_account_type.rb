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

    field :lists,
          resolver: Resolvers::Lists,
          connection: true,
          description: I18n.t("#{I18N_PATH}.fields.lists")

    field :favorite_movies_list,
          connection: true,
          resolver: Resolvers::FavoriteMovies,
          description: I18n.t("#{I18N_PATH}.fields.favorite_movies_list")

    field :watchlist_movies_list,
          connection: true,
          resolver: Resolvers::WatchlistMovies,
          description: I18n.t("#{I18N_PATH}.fields.watchlist_movies_list")
  end
end
