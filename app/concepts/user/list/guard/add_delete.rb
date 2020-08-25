# frozen_string_literal: true

module User::List
  module Guard
    class AddDelete < ApplicationGuard
      def call(ctx, **)
        @ctx = ctx

        owned_list?
      end

      private

      def owned_list?
        id = @ctx[:params][:list_id] || @ctx[:params][:id]

        ::List.exists?(id: id, user_account_id: current_user.id)
      end
    end
  end
end
