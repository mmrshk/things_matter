# frozen_string_literal: true

module Mutations
  module User::Note::Tag
    class Delete < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.user.note.tag.delete.desc')

      argument :input, Types::Inputs::DeleteInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Note::Tag::Operation::Delete.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end