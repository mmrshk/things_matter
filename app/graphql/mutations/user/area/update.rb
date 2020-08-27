# frozen_string_literal: true

module Mutations
  module User::Area
    class Update < AuthenticableMutation
      type Types::UserAccountType

      description I18n.t('graphql.mutations.user.area.update.desc')

      argument :input, Types::Inputs::AreaUpdateInput, required: true

      def resolve(input:)
        match_operation ::Api::V1::User::Area::Operation::Update.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
