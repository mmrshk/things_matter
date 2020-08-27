class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.string :name
      t.text :description
      t.boolean :default, default: false

      t.belongs_to :area, type: :uuid, foreign_key: true, null: true
      t.belongs_to :project, type: :uuid, foreign_key: true, null: true
      t.belongs_to :user_account, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
