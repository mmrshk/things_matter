# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def belongs_to_user_account?
    user_account? && record.task_project.user_account.id == user.id
  end

  def belongs_to_user_account_through_params?
    user_account? && project_through_params_belongs_to_user? && task_through_params_belongs_to_user?
  end

  def task_through_params_belongs_to_user?
    user.tasks.exists?(id: record[:id])
  end

  def project_through_params_belongs_to_user?
    user.task_projects.exists?(id: record[:task_project_id])
  end
end
