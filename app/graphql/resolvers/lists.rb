# frozen_string_literal: true

module Resolvers
  class Lists < AuthBase
    type Types::Connections::ListConnection, null: false

    def resolve
      current_user.lists
    end
  end
end
