class CreateUserAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_accounts, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.timestamps
    end

    add_index :user_accounts, :email, unique: true
  end
end
