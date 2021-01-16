# frozen_string_literal: true

module Mutations
  module User::Task::Tag
    class Update < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.user.task.tag.update.desc')

      argument :input, Types::Inputs::TaskTagUpdateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Task::Tag::Operation::Update.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
