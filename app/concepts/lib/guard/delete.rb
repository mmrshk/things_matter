# frozen_string_literal: true

module List::Guard
  class Delete < ::ApplicationGuard
    def call(ctx, **)
      @ctx = ctx

      owned_list?
    end

    private

    def owned_list?
      ::List.exists?(id: ctx[:model].id, user_account_id: current_user.id)
    end
  end
end
