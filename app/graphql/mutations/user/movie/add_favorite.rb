# frozen_string_literal: true

module Mutations
  module User::Movie
    class AddFavorite < AuthenticableMutation
      type Types::MovieType

      description I18n.t('graphql.mutations.user.movie.add_favorite.desc')

      argument :input, Types::Inputs::UserAddFavoriteMovieInput, required: true

      def resolve(input:)
        match_operation ::User::Movie::Operation::AddFavorite.call(
          current_user: current_user,
          params: input.to_h
        )
      end
    end
  end
end
