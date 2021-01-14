# frozen_string_literal: true

module Mutations
  module User::Note::Tag
    class Update < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.user.note.tag.update.desc')

      argument :input, Types::Inputs::NoteTagUpdateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Note::Tag::Operation::Update.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
