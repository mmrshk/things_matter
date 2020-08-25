# frozen_string_literal: true

module Mutations
  module User::List
    class Delete < Mutations::AuthenticableMutation
      type Types::DeleteListType

      description I18n.t('graphql.mutations.user.list.delete.desc')

      argument :input, Types::Inputs::DeleteInput, required: true

      def resolve(input:)
        match_operation ::User::List::Operation::Delete.call(
          current_user: current_user,
          params: input.to_h
        )
      end
    end
  end
end
