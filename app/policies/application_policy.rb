# frozen_string_literal: true

class ApplicationPolicy < ActionPolicy::Base
  def user_account?
    user
  end
end
