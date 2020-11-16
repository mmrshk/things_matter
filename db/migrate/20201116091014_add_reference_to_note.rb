class AddReferenceToNote < ActiveRecord::Migration[6.0]
  def change
    add_reference :notes, :user_account, index: true, type: :uuid
  end
end
