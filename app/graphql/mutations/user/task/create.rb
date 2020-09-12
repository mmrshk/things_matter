# frozen_string_literal: true

module Mutations
  module User::Task
    class Create < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.task.create.desc')

      argument :input, Types::Inputs::TaskCreateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Task::Operation::Create.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
