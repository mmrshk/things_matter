class CreateNoteTags < ActiveRecord::Migration[6.0]
  def change
    create_table :note_tags, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.belongs_to :note, foreign_key: true, index: true, type: :uuid
      t.string :name, null: false

      t.timestamps
    end
  end
end
