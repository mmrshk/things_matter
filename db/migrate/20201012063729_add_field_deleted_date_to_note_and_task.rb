class AddFieldDeletedDateToNoteAndTask < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :deleted_date, :date
    add_column :tasks, :deleted_date, :date
    add_column :task_projects, :deleted_date, :date
    add_column :note_projects, :deleted_date, :date
  end
end
