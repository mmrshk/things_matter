# frozen_string_literal: true

module Mutations
  module User::Project
    class Create < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.project.create.desc')

      argument :input, Types::Inputs::ProjectCreateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Project::Operation::Create.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
