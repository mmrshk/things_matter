# frozen_string_literal: true

class NoteProjectPolicy < ProjectPolicy
  def belongs_to_user_account_through_params?
    user_account? && note_project_by_id_exists?(id: record)
  end

  def area_and_project_belongs_to_user_account_through_params?
    user_account? && note_project_by_id_exists?(id: record[:id]) && area_belongs_to_user?
  end

  private

  def area_belongs_to_user?
    NoteArea.exists?(id: record[:area_id], user_account_id: user.id)
  end

  def note_project_by_id_exists?(id:)
    NoteProject.exists?(id: id, user_account_id: user.id)
  end
end
