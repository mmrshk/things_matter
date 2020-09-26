# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
  def belongs_to_user_account?
    user_account? && record.note_project.user_account.id == user.id
  end

  def belongs_to_user_account_through_params?
    user_account? && project_through_params_belongs_to_user? && note_through_params_belongs_to_user?
  end

  def note_through_params_belongs_to_user?
    user.notes.exists?(id: record[:id])
  end

  def project_through_params_belongs_to_user?
    user.note_projects.exists?(id: record[:note_project_id])
  end
end
