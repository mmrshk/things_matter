# frozen_string_literal: true

class ApplicationGuard
  include Uber::Callable

  protected

  def current_user
    @ctx[:current_user]
  end

  def current_user_allow_action?
    current_user.id.to_s == @ctx[:params][:user_account_id]
  end
end
