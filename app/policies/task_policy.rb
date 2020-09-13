# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def belongs_to_user_account?
    user_account? && record.task_project.user_account.id == user.id
  end
end
