# frozen_string_literal: true

module Mutations
  module User::Movie
    class AddWatchlist < AuthenticableMutation
      type Types::MovieType

      description I18n.t('graphql.mutations.user.movie.add_watchlist.desc')

      argument :input, Types::Inputs::UserAddWatchlistMovieInput, required: true

      def resolve(input:)
        match_operation ::User::Movie::Operation::AddWatchlist.call(
          current_user: current_user,
          params: input.to_h
        )
      end
    end
  end
end
