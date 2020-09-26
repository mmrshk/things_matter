# frozen_string_literal: true

class TaskProjectPolicy < ProjectPolicy
  def belongs_to_user_account_through_params?
    user_account? && task_project_by_id_exists?(id: record)
  end

  def area_and_project_belongs_to_user_account_through_params?
    user_account? && task_project_by_id_exists?(id: record[:id]) && area_belongs_to_user?
  end

  private

  def area_belongs_to_user?
    TaskArea.exists?(id: record[:area_id], user_account_id: user.id)
  end

  def task_project_by_id_exists?(id:)
    TaskProject.exists?(id: id, user_account_id: user.id)
  end
end
