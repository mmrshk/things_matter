class CreateTaskImages < ActiveRecord::Migration[6.0]
  def change
    create_table :task_images, id: :uuid, default: -> { 'uuid_generate_v4()' }, force: :cascade do |t|
      t.belongs_to :task, type: :uuid, foreign_key: true, index: true
      t.integer :position, default: 0, null: false
      t.timestamps
    end
  end
end
