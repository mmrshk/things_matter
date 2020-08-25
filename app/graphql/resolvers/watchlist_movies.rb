# frozen_string_literal: true

module Resolvers
  class WatchlistMovies < AuthBase
    type Types::Connections::MovieConnection, null: false

    def resolve
      current_user.watchlist_movies_list
    end
  end
end
