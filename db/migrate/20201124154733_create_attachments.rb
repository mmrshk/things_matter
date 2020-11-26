class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.uuid :attachable_id
      t.string  :attachable_type
      t.string  :type

      t.string :file

      t.timestamps null: false
    end

    add_index :attachments, %i[attachable_id attachable_type], unique: true
    add_index :attachments, :type
  end
end
