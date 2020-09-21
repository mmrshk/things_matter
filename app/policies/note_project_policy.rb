# frozen_string_literal: true

class NoteProjectPolicy < ProjectPolicy
  def belongs_to_user_account_through_params?
    user_account? && NoteProject.exists?(id: record, user_account_id: user.id)
  end
end
