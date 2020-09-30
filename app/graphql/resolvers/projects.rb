# frozen_string_literal: true

module Resolvers
  class Projects < AuthBase
    type Types::Connections::ProjectConnection, null: false

    argument :filter, String, required: false

    def resolve(filter: nil)
      match_operation ::Api::V1::User::TaskProject::Operation::Index.call(filter: filter, current_user: current_user)
    end
  end
end
