# frozen_string_literal: true

module Mutations
  module User::List
    class AddItem < AuthenticableMutation
      type Types::ListType

      description I18n.t('graphql.mutations.user.list.add_item.desc')

      argument :input, Types::Inputs::List::AddItemInput, required: true

      def resolve(input:)
        match_operation ::User::List::Item::Operation::Add.call(
          params: input.to_h,
          current_user: current_user
        )
      end
    end
  end
end
