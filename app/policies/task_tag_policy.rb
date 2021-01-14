# frozen_string_literal: true

class TaskTagPolicy < ApplicationPolicy
  def belongs_to_user_account_through_params?
    user_account? && task_id_exists?(id: record)
  end

  def belongs_to_user_account?
    user_account? && record.task.user_account.id == user.id
  end

  private

  def task_id_exists?(id: id)
    Task.exists?(id: id, user_account_id: user.id)
  end
end
