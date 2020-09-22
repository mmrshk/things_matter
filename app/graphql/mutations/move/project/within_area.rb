# frozen_string_literal: true

module Mutations
  module Move::Project
    class WithinArea < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.move.project.within_area.desc')

      argument :input, Types::Inputs::Move::ProjectWithinAreaInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::Move::Project::Operation::WithinAreaStrategy.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
