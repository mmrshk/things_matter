# frozen_string_literal: true

module Resolvers
  class Tasks < AuthBase
    type Types::Connections::TaskConnection, null: false

    argument :input, Types::Inputs::TaskFilterInput, required: false

    def resolve(input: {})
      match_operation ::Api::V1::User::Task::Operation::Index.call(params: input.to_h, current_user: current_user)
    end
  end
end
