# frozen_string_literal: true

module Mutations
  module User::TaskProject
    class Update < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.project.update.desc')

      argument :input, Types::Inputs::TaskProjectUpdateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::TaskProject::Operation::Update.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
