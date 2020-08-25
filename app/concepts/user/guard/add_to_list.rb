# frozen_string_literal: true

module User::Guard
  class AddToList < ::ApplicationGuard
    def call(ctx, **)
      @ctx = ctx

      current_user_allow_action?
    end
  end
end
