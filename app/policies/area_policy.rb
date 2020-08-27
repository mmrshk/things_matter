# frozen_string_literal: true

class AreaPolicy < ApplicationPolicy
  def belongs_to_user_account?
    record.user_account_id == user.id
  end
end
