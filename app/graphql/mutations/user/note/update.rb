# frozen_string_literal: true

module Mutations
  module User::Note
    class Update < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.note.update.desc')

      argument :input, Types::Inputs::NoteUpdateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Note::Operation::Update.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
