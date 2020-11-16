# frozen_string_literal: true

module Mutations
  module User::Task
    class Recover < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.task.recover.desc')

      argument :input, Types::Inputs::TaskRecoverInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Task::Operation::Recover.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
