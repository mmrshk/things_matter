# frozen_string_literal: true

module Resolvers
  class Notes < AuthBase
    type Types::Connections::NoteConnection, null: false

    argument :input, Types::Inputs::NoteFilterInput, required: false

    def resolve(input: nil)
      return scope unless input

      scope.reorder("#{input[:sort]} #{input[:direction]}") if input[:sort]
    end

    def scope
      @scope = current_user.notes.order(position: :asc)
    end
  end
end
