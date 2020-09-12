class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.string :name, default: ''
      t.text :description
      t.boolean :done, default: false
      t.boolean :deleted, default: false
      t.date :deadline
      t.date :to_do_day

      t.belongs_to :project, type: :uuid, foreign_key: true, null: true

      t.timestamps
    end
  end
end
