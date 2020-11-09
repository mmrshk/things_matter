class AddReferenceToTaskForUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :user_account, index: true, type: :uuid
  end
end
