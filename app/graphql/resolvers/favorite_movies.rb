# frozen_string_literal: true

module Resolvers
  class FavoriteMovies < AuthBase
    type Types::Connections::MovieConnection, null: false

    argument :order_by,
             Types::Inputs::MovieOrderingInput,
             required: false,
             prepare: ->(order_by, _ctx) { order_by.to_h }

    def resolve(order_by: nil)
      order(order_by) if order_by
      scope
    end

    private

    def order(order_by)
      @scope = scope.reorder(order_by[:sort] => order_by[:direction])
    end

    def scope
      @scope ||= current_user.favorite_movies_list
    end
  end
end
