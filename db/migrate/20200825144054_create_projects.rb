class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :task_projects, id: :uuid, default: -> { 'uuid_generate_v4()' }  do |t|
      t.string :name, default: ''
      t.date :deadline
      t.belongs_to :task_area, type: :uuid, foreign_key: true, null: true
      t.belongs_to :user_account, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end

    create_table :note_projects, id: :uuid, default: -> { 'uuid_generate_v4()' }  do |t|
      t.string :name, default: ''
      t.date :deadline
      t.belongs_to :note_area, type: :uuid, foreign_key: true, null: true
      t.belongs_to :user_account, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
