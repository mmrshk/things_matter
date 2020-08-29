# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def belongs_to_user_account?
    user_account? && record.user_account_id == user.id
  end
end
