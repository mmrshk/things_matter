# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
  def belongs_to_user_account?
    user_account? && record.project.user_account.id == user.id
  end
end
