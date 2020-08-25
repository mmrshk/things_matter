# frozen_string_literal: true

module Types::Inputs
  class UserAddWatchlistMovieInput < ::Types::Base::InputObject
    I18N_PATH = 'graphql.inputs.user.add_watchlist_movie_input'

    graphql_name 'UserAddWatchlistMovieInput'

    description I18n.t("#{I18N_PATH}.desc")

    argument :user_account_id, ID, required: true, description: I18n.t("#{I18N_PATH}.args.user_id")
    argument :movie_id, ID, required: true, description: I18n.t("#{I18N_PATH}.args.movie_id")
  end
end
