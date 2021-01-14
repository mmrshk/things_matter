# frozen_string_literal: true

module Mutations
  module User::Task::Tag
    class Create < AuthenticableMutation
      type Types::CompletionStatusType

      description I18n.t('graphql.mutations.user.task.tag.create.desc')

      argument :input, Types::Inputs::TaskTagCreateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Task::Tag::Operation::Create.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
