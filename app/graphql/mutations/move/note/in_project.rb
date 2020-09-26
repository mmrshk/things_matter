# frozen_string_literal: true

module Mutations
  module Move::Note
    class InProject < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.move.note.in_project.desc')

      argument :input, Types::Inputs::Common::MoveInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::Move::Note::Operation::InProject.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
