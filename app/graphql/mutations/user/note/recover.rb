# frozen_string_literal: true

module Mutations
  module User::Note
    class Recover < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.note.recover.desc')

      argument :input, Types::Inputs::NoteRecoverInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Note::Operation::Recover.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
