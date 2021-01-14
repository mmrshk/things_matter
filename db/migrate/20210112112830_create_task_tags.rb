class CreateTaskTags < ActiveRecord::Migration[6.0]
  def change
    create_table :task_tags, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.belongs_to :task, foreign_key: true, index: true, type: :uuid
      t.string :name, null: false

      t.timestamps
    end
  end
end
