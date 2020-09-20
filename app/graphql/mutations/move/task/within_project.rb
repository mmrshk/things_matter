# frozen_string_literal: true

module Mutations
  module Move::Task
    class WithinProject < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.move.task.within_project.desc')

      argument :input, Types::Inputs::Move::TaskWithinProjectInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::Move::Task::Operation::WithinProject.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
