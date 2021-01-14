# frozen_string_literal: true

class NoteTagPolicy < ApplicationPolicy
  def belongs_to_user_account_through_params?
    user_account? && note_id_exists?(note_id: record)
  end

  def belongs_to_user_account?
    user_account? && record.note.user_account.id == user.id
  end

  private

  def note_id_exists?(note_id:)
    Note.exists?(id: note_id, user_account_id: user.id)
  end
end
