# frozen_string_literal: true

module Resolvers
  class Tasks < AuthBase
    type Types::Connections::TaskConnection, null: false

    argument :filter, String, required: false

    def resolve(filter: nil)
      match_operation ::Api::V1::User::Task::Operation::Index.call(filter: filter, current_user: current_user)
    end
  end
end
