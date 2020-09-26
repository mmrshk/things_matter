# frozen_string_literal: true

module Mutations
  module Move::Area
    class WithinArea < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.move.area.within_area.desc')

      argument :input, Types::Inputs::Common::MoveInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::Move::Area::Operation::WithinArea.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
