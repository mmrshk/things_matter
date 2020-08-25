# frozen_string_literal: true

module Mutations
  module User::List
    class Create < Mutations::AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.list.create.desc')

      argument :input, Types::Inputs::UserCreateListInput, required: true

      def resolve(input:)
        match_operation ::User::List::Operation::Create.call(
          current_user: current_user,
          params: input.to_h
        )
      end
    end
  end
end
