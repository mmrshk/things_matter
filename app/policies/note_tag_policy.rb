# frozen_string_literal: true

class NoteTagPolicy < ApplicationPolicy
  def belongs_to_user_account_through_params?
    user_account? && note_id_exists?(id: record)
  end

  def belongs_to_user_account?
    user_account? && record.note.user_account.id == user.id
  end

  private

  def note_id_exists?(id: id)
    Note.exists?(id: id, user_account_id: user.id)
  end
end
