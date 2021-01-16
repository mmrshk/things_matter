# frozen_string_literal: true

module Resolvers
  class TaskTags < AuthBase
    type [Types::TaskTagType], null: false

    argument :id, ID, required: false

    def resolve(id: nil)
      return [] unless id

      match_operation ::Api::V1::User::Task::Tag::Operation::Index.call(
        params: { id: id },
        current_user: current_user
      )
    end
  end
end
