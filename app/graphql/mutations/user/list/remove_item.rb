# frozen_string_literal: true

module Mutations
  module User::List
    class RemoveItem < AuthenticableMutation
      type Types::ListItemDeleteType

      description I18n.t('graphql.mutations.user.list.remove_item.desc')

      argument :input, Types::Inputs::List::RemoveItemInput, required: true

      def resolve(input:)
        match_operation ::User::List::Item::Operation::Delete.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
