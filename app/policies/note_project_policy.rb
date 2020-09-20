# frozen_string_literal: true

class NoteProjectPolicy < ApplicationPolicy
  def belongs_to_user_account?
    user_account? && record.user_account_id == user.id
  end

  def belongs_to_user_account_through_params?
    user_account? && NoteProject.exists?(id: record, user_account_id: user.id)
  end
end