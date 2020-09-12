# frozen_string_literal: true

module Mutations
  module User::NoteProject
    class Create < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.project.create.desc')

      argument :input, Types::Inputs::NoteProjectCreateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::NoteProject::Operation::Create.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
