class AddFieldDeletedToNote < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :deleted, :boolean, default: false
    add_column :task_projects, :deleted, :boolean, default: false
    add_column :note_projects, :deleted, :boolean, default: false
  end
end
