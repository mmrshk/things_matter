class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid, default: -> { 'uuid_generate_v4()' } do |t|
      t.string :name
      t.text :description
      t.boolean :done, default: false
      t.boolean :deleted, default: false
      t.datetime :deadline
      t.datetime :to_do_day

      t.belongs_to :areas, type: :uuid, foreign_key: true, null: true
      t.belongs_to :projects, type: :uuid, foreign_key: true, null: true
      t.belongs_to :user_account, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
