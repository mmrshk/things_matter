class CreateNoteImages < ActiveRecord::Migration[6.0]
  def change
    create_table :note_images, id: :uuid, default: -> { 'uuid_generate_v4()' }, force: :cascade do |t|
      t.belongs_to :note, type: :uuid, foreign_key: true, index: true
      t.integer :position, default: 0, null: false
      t.timestamps
    end
  end
end
